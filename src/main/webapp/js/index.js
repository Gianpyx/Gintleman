/* 
 * Gintleman - Script Homepage (index.js)
 * Gestisce le animazioni allo scroll e l'interattività della home.
 */

document.addEventListener("DOMContentLoaded", function() {
    
    // Seleziona tutti gli elementi che devono animarsi all'entrata
    const hiddenElements = document.querySelectorAll('.card, .banner-box, .category-card');

    // Configura l'Observer
    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add('show-on-scroll');
            }
        });
    }, {
        threshold: 0.1 // Attiva quando il 10% dell'elemento è visibile
    });

    // Applica l'Observer
    hiddenElements.forEach((el) => {
        el.classList.add('hidden-on-scroll'); // Classe base invisibile
        observer.observe(el);
    });

});
