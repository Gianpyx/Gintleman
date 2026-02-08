(function () {
  /*
   * Gestione Header
   * Naming var e funzioni in Italiano
   */
  const testata = document.querySelector(".testata");
  if (!testata) return;

  function impostaAltezzaHeader() {
    const h = testata.offsetHeight;
    document.documentElement.style.setProperty("--header-height", h + "px");
    document.documentElement.style.setProperty(
      "--header-height-neg",
      -h + "px",
    );
  }
  impostaAltezzaHeader();
  window.addEventListener("resize", impostaAltezzaHeader, { passive: true });
  window.addEventListener("load", impostaAltezzaHeader);

  let ultimoY = window.scrollY || 0;
  let inEsecuzione = false;
  const soglia = 10;

  function alloScroll() {
    const y = window.scrollY || 0;
    if (Math.abs(y - ultimoY) > soglia) {
      if (y > ultimoY && y > testata.offsetHeight) {
        testata.classList.add("nascosta"); // Usiamo 'nascosta' invece di 'is-hidden'
      } else {
        testata.classList.remove("nascosta");
      }
      ultimoY = y;
    }
    inEsecuzione = false;
  }

  window.addEventListener(
    "scroll",
    function () {
      if (!inEsecuzione) {
        requestAnimationFrame(alloScroll);
        inEsecuzione = true;
      }
    },
    { passive: true },
  );

  /* Logica Burger Menu */
  const bottoneBurger = document.getElementById("menu-hamburger");
  const cassetto = document.getElementById("cassetto-navigazione");

  if (bottoneBurger && cassetto) {
    bottoneBurger.addEventListener("click", function () {
      cassetto.classList.toggle("aperto");
      
      // Accessibilità e Stato
      const aperto = cassetto.classList.contains("aperto");
      bottoneBurger.setAttribute("aria-expanded", aperto);
      
      // Blocca lo scroll del body quando il menu è aperto?
       if (aperto) {
           document.body.style.overflow = "hidden";
       } else {
           document.body.style.overflow = "";
       }
    });
  }
})();
