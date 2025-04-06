<script lang="ts">
  import Navbar from "$lib/components/Navbar.svelte";
  import Player1 from "$lib/components/Player1.svelte";
  import Player2 from "$lib/components/Player2.svelte";
  import "../app.css";

  let { children } = $props();
</script>

<Navbar />
<main class="m-2 flex flex-col items-center">
  {@render children()}
</main>
<!-- <Player1 /> -->
<Player2 />
