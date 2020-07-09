import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: [
    "mojito",
    "007 Martini",
    "vermouth",
    "Long Island Iced Tea",
    "screwdriver",
    "saké",
    "caipiroska",
    "rum",
    "tropical itch",
    "gin",
    "metropolis",
    "Absinthe",
    "tuxedo",
    "Tequila",
    "Ice Pick",
    "sherry",
    ],
    attr: 'placeholder',
    typeSpeed: 100,
    loop: true
  });
}

export { loadDynamicBannerText };
