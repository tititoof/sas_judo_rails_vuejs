<template>
  <div id="app">
    <p>{{ message }}</p>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'

@Component
export default class App extends Vue {
  message: string = 'Hello Vue with Typescript héhé works now commit !!!!'
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
