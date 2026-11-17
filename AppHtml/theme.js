(function () {
    "use strict";

    const storageKey = "futbolWebApp.theme";
    const page = document.documentElement;

    try {
        page.classList.toggle("FootballDark", localStorage.getItem(storageKey) === "dark");
    } catch {
        // The theme can still be changed when browser storage is unavailable.
    }

    function updateButton(button) {
        const dark = page.classList.contains("FootballDark");
        button.setAttribute("aria-pressed", String(dark));
        button.title = dark ? "Cambiar a modo claro" : "Cambiar a modo oscuro";
    }

    function toggleTheme(button) {
        const dark = page.classList.toggle("FootballDark");
        updateButton(button);

        try {
            localStorage.setItem(storageKey, dark ? "dark" : "light");
        } catch {
            // Keep the selection active for this page.
        }
    }

    window.footballTheme = {
        onRender(event) {
            updateButton(event.oSource._eControl);
        },
        toggle(event) {
            const button = event.oSource._eControl;
            const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

            if (!reduceMotion && typeof document.startViewTransition === "function") {
                document.startViewTransition(() => toggleTheme(button));
            } else {
                toggleTheme(button);
            }
        }
    };
})();
