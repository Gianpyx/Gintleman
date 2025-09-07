    (function () {
    const header = document.querySelector('.header');
    if (!header) return;

    function setHeaderHeightVar() {
    const h = header.offsetHeight;
    document.documentElement.style.setProperty('--header-height', h + 'px');
    document.documentElement.style.setProperty('--header-height-neg', (-h) + 'px');
}
    setHeaderHeightVar();
    window.addEventListener('resize', setHeaderHeightVar, { passive: true });
    window.addEventListener('load', setHeaderHeightVar);

    let lastY = window.scrollY || 0;
    let ticking = false;
    const threshold = 10;

    function onScroll() {
    const y = window.scrollY || 0;
    if (Math.abs(y - lastY) > threshold) {
    if (y > lastY && y > header.offsetHeight) {
    header.classList.add('is-hidden');
} else {
    header.classList.remove('is-hidden');
}
    lastY = y;
}
    ticking = false;
}

    window.addEventListener('scroll', function () {
    if (!ticking) {
    requestAnimationFrame(onScroll);
    ticking = true;
}
}, { passive: true });
})();