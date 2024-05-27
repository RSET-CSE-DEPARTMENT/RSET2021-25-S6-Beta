(function() {
  const svgFilter = `
    <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
      <defs>
        <filter id="redToGrey">
          <feColorMatrix type="matrix" values="
            0.3333 0.3333 0.3333 0 0
            0        0        0        1 0
            0.3333 0.3333 0.3333 0 0
            0        0        0        1 0
            1        0        0        0 1
          "/>
        </filter>
      </defs>
    </svg>
  `;

  const injectFilter = () => {
    const style = document.createElement("style");
    style.textContent = `img[src] { filter: url(data:image/svg+xml;base64,${btoa(svgFilter)})#redToGrey; }`;
    document.head.appendChild(style);
  };

  const observer = new MutationObserver(injectFilter);
  observer.observe(document.body, { childList: true, subtree: true });
  injectFilter();
})();
