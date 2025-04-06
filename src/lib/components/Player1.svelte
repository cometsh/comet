<script lang="ts">
  import {
    List,
    Pause,
    Play,
    Repeat,
    Shuffle,
    SkipBack,
    SkipForward,
    Volume2,
    type Icon as LucideIcon,
  } from "@lucide/svelte";
  import { Slider } from "bits-ui";
  import cn from "clsx";

  let playing = $state(true);
  let shuffle = $state(false);
  let repeat = $state(false);

  const MainIcon = $derived(playing ? Pause : Play);

  const songLength = 256;
  let playback = $state(0);
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
<aside
  class="fixed right-2 bottom-2 left-2 flex items-center gap-4 rounded-lg border border-slate-300 bg-white p-2 px-4 text-slate-500"
>
  <div class="flex items-center gap-2 text-slate-900">
    {@render plainButton(SkipBack, "Previous song")}
    <button
      class="flex cursor-pointer items-center justify-center rounded-full bg-orange-500 p-2 text-white"
      aria-label="Play"
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
    <div class="flex flex-col">
      <span class="text-sm font-semibold text-slate-900 opacity-70">
        {@render clickable("Protostar")}, {@render clickable("Laminar")} & {@render clickable(
          "imallryt",
        )}
      </span>
      <span class="font-bolder text-sm font-semibold text-slate-900">
        {@render clickable("Blood in the Water")}
        <!-- <span class="opacity-50">| {@render clickable("Epic Album")}</span> -->
      </span>
    </div>
  </div>

  <div class="flex flex-1 px-30">
    <Slider.Root
      type="single"
      bind:value={playback}
      max={songLength}
      class="relative flex flex-1 touch-none items-center select-none"
    >
      {#snippet children()}
        <span
          class="relative h-1 w-full cursor-pointer overflow-hidden rounded-full bg-slate-200"
        >
          <Slider.Range class="absolute h-full rounded-full bg-orange-500" />
        </span>
        <Slider.Thumb
          index={0}
          class="block size-4 cursor-pointer rounded-full border border-slate-900 bg-slate-50 focus-visible:ring focus-visible:ring-orange-500 focus-visible:ring-offset-2 "
        />
      {/snippet}
    </Slider.Root>
  </div>

  <button
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
  </button>

  <List class="cursor-pointer" />
  <Volume2 class="cursor-pointer" />
</aside>
