const BG = [
  "lightgreen",
  "yellow",
  "aqua"
]
document.addEventListener("readystatechange", () => {
  if (document.readyState === "complete") {
    let ele = document.querySelector("h1")
    let count = 0
    setInterval(() => {
      ele.style.background = BG[count % BG.length]
      count ++
    }, 1000)
  }
})