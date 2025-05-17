<script lang="ts">
  import {
    ChevronDown,
    List,
    Pause,
    Play,
    Repeat,
    Repeat1,
    Shuffle,
    SkipBack,
    SkipForward,
    Volume2,
    type Icon as LucideIcon,
  } from "@lucide/svelte";
  import { Slider } from "bits-ui";
  import cn from "clsx";

  let expanded = $state(true);
  let playing = $state(false);
  let shuffle = $state(false);
  let repeat: "none" | "all" | "one" = $state("none");
  let interval: ReturnType<typeof setInterval>;

  const MainIcon = $derived(playing ? Pause : Play);
  const RepeatIcon = $derived.by(() => (repeat === "one" ? Repeat1 : Repeat));

  // TODO: separate progress state so that the thumb does not jump around to it's real value while the user is dragging it.
  // Probably done through checking click state of the thumb and temporarily disconnecting the progress?
  const songLength = 256;
  let playback = $state(0);

  $effect(() => {
    // console.log({ playback });

    if (playing)
      interval = setInterval(() => {
        playback++;
        if (playback > songLength) playback = 0;
      }, 1000);
    else clearInterval(interval);
  });

  // TODO: see if I need to i18n time format.
  const formatTime = (inputSeconds: number) => {
    const minutes = Math.floor(inputSeconds / 60);
    const seconds = `${inputSeconds % 60}`.padStart(2, "0");

    return `${minutes}:${seconds}`;
  };

  const cycleRepeat = () => {
    if (repeat === "none") repeat = "all";
    else if (repeat === "all") repeat = "one";
    else repeat = "none";
  };
</script>

{#snippet plainButton(Icon: typeof LucideIcon, label: string)}
  <button class="flex cursor-pointer" aria-label={label}>
    <Icon />
  </button>
{/snippet}

{#snippet clickable(content: string)}
  <span class="cursor-pointer hover:underline">{content}</span>
{/snippet}

<!-- TODO: labelled by the artist & title -->
<!-- TODO: keep width when collapsed? -->
<aside
  class="fixed bottom-2 left-2 flex flex-col gap-2 overflow-hidden rounded-lg border border-slate-300 bg-white"
>
  <header class="flex gap-2 bg-black p-2 text-slate-50">
    <button
      class={cn("flex cursor-pointer transition-transform", {
        "rotate-180": !expanded,
      })}
      onclick={() => (expanded = !expanded)}
    >
      <ChevronDown />
    </button>
    {#if expanded}
      <span class="font-bold">Now Playing</span>
      <div class="flex-1"></div>

      <button
        class={cn("flex", "cursor-pointer", { "text-orange-500": shuffle })}
        onclick={() => (shuffle = !shuffle)}
      >
        <Shuffle />
      </button>
      <button
        class={cn("flex", "cursor-pointer", {
          "text-orange-500": repeat !== "none",
        })}
        onclick={cycleRepeat}
      >
        <RepeatIcon />
      </button>

      <List class="cursor-pointer" />
      <Volume2 class="cursor-pointer" />
    {:else}
      <div class="flex gap-1">
        <button
          class="flex cursor-pointer"
          aria-label={playing ? "Pause current song" : "Play current song"}
          onclick={() => (playing = !playing)}
        >
          <MainIcon />
        </button>
        <!-- TODO: scrolling text -->
        <div class="line-clamp-1 max-w-[300px] text-ellipsis">
          <span>Protostar, Laminar, imallryt</span>
          -
          <span>Blood in the Water</span>
        </div>

        <Volume2 class="cursor-pointer" />
      </div>
    {/if}
  </header>

  {#if expanded}
    <div class="flex flex-col gap-2 px-4 py-2 text-slate-500">
      <div class="flex items-center gap-4">
        <div class="flex items-center gap-2 text-slate-900">
          {@render plainButton(SkipBack, "Previous song")}
          <button
            class="flex cursor-pointer items-center justify-center rounded-full bg-orange-500 p-2 text-white"
            aria-label={playing ? "Pause current song" : "Play current song"}
            onclick={() => (playing = !playing)}
          >
            <MainIcon />
          </button>
          {@render plainButton(SkipForward, "Next song")}
        </div>

        <div class="flex items-center gap-2">
          <img
            src="https://lh3.googleusercontent.com/0z6Kg2GFi8hFgZYxWm3c3UNul0gyaCQjuqmY-p1oeFC1n5EMOf1dxrownTzhzk-_cdtO_FLLktQcMecwGQ=w544-h544-l90-rj"
            class="h-12 w-12 rounded object-cover object-center"
            alt=""
          />
          <!-- TODO: max width with scrolling texts -->
          <div class="flex flex-col">
            <span class="text-sm font-semibold text-slate-900 opacity-70">
              {@render clickable("Protostar")}, {@render clickable("Laminar")} &
              {@render clickable("imallryt")}
            </span>
            <span class="font-bolder text-sm font-semibold text-slate-900">
              {@render clickable("Blood in the Water")}
              <!-- <span class="opacity-50">| {@render clickable("Epic Album")}</span> -->
            </span>
          </div>
        </div>
      </div>

      <div class="flex w-full gap-2 py-2">
        <Slider.Root
          type="single"
          max={songLength}
          class="relative flex flex-1 touch-none items-center select-none"
          value={playback}
          onValueCommit={(value) => (playback = value)}
        >
          {#snippet children()}
            <span
              class="relative h-1 w-full cursor-pointer overflow-hidden rounded-full bg-slate-200"
            >
              <Slider.Range
                class="absolute h-full rounded-full bg-orange-500"
              />
            </span>
            <Slider.Thumb
              index={0}
              class="block size-4 cursor-pointer rounded-full border border-slate-900 bg-slate-50 focus-visible:ring focus-visible:ring-orange-500 focus-visible:ring-offset-2 "
            />
          {/snippet}
        </Slider.Root>

        <span class="text-sm">
          {formatTime(playback)}/{formatTime(songLength)}
        </span>

        <!-- <button
        class={cn("flex", "cursor-pointer", { "text-orange-500": shuffle })}
        onclick={() => (shuffle = !shuffle)}
      >
        <Shuffle />
      </button>
      <button
        class={cn("flex", "cursor-pointer", { "text-orange-500": repeat })}
        onclick={() => (repeat = !repeat)}
      >
        <Repeat />
      </button> -->
      </div>
    </div>
  {/if}
</aside>
