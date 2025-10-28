(function () {
    // open modal
    document.querySelectorAll(".hc-tile[data-modal]").forEach(function (btn) {
        btn.addEventListener("click", function () {
            var sel = btn.getAttribute("data-modal");
            var modal = document.querySelector(sel);
            if (!modal) return;
            modal.removeAttribute("hidden");
            // fokuskan tombol close untuk aksesibilitas
            var closer = modal.querySelector("[data-close]") || modal;
            closer.focus && closer.focus();
        });
    });

    // close modal via tombol [data-close]
    document.addEventListener("click", function (e) {
        var closer = e.target.closest("[data-close]");
        if (!closer) return;
        var modal = closer.closest(".hc-modal");
        if (modal) modal.setAttribute("hidden", "");
    });

    // close modal kalau klik overlay di luar panel
    document.querySelectorAll(".hc-modal").forEach(function (m) {
        m.addEventListener("click", function (e) {
            var panel = m.querySelector(".hc-panel");
            if (!panel) return;
            if (!panel.contains(e.target)) {
                m.setAttribute("hidden", "");
            }
        });
    });

    // esc untuk close semua modal
    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
            document.querySelectorAll(".hc-modal").forEach(function (m) {
                m.setAttribute("hidden", "");
            });
        }
    });
})();
