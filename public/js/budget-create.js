(function () {
    const sel = document.getElementById("tplSelect");
    const total = document.getElementById("totalBudget");
    const desc = document.getElementById("descInput");

    function formatRupiah(n) {
        try {
            return (
                "Rp " +
                Math.round(n || 0)
                    .toString()
                    .replace(/\B(?=(\d{3})+(?!\d))/g, ".")
            );
        } catch (e) {
            return "Rp " + n;
        }
    }

    async function onTplChange() {
        const id = sel.value;
        if (!id) {
            total.value = "";
            desc.value = "";
            return;
        }

        const patt = sel.getAttribute("data-detail-url");
        const url = (patt || "/budgets/templates/__ID__/detail").replace(
            "__ID__",
            id
        );

        try {
            const res = await fetch(url, {
                headers: {
                    Accept: "application/json",
                    "X-Requested-With": "XMLHttpRequest",
                },
                credentials: "same-origin",
            });
            const data = await res.json();
            if (!data.ok) throw new Error("Template not found");

            total.value = formatRupiah(data.template.grand_total || 0);
            desc.value = data.template.description || "";
        } catch (err) {
            console.error(err);
            total.value = "";
            desc.value = "";
        }
    }

    sel && sel.addEventListener("change", onTplChange);

    // Date picker enhancement
    document.addEventListener("DOMContentLoaded", () => {
        const from = document.getElementById("periodeFrom");
        const to = document.getElementById("periodeTo");

        // ====== 1️⃣ Buka kalender saat klik di mana saja ======
        document
            .querySelectorAll('input[type="date"].date-picker')
            .forEach((input) => {
                input.addEventListener("click", (e) => {
                    try {
                        e.target.showPicker(); // Browser modern (Chrome, Edge)
                    } catch (err) {
                        e.target.focus(); // Fallback untuk browser lain
                    }
                });
            });

        // ====== 2️⃣ Validasi: tanggal akhir ≥ tanggal awal ======
        if (from && to) {
            from.addEventListener("change", () => {
                // Kalau user ubah tanggal awal → set minimal tanggal akhir
                to.min = from.value;
                if (to.value && to.value < from.value) {
                    alert(
                        "Tanggal akhir tidak boleh lebih awal dari tanggal mulai."
                    );
                    to.value = from.value;
                }
            });

            to.addEventListener("change", () => {
                if (from.value && to.value < from.value) {
                    alert(
                        "Tanggal akhir tidak boleh lebih awal dari tanggal mulai."
                    );
                    to.value = from.value;
                }
            });
        }
    });

    (function () {
        const tplInput = document.getElementById("tplInput");
        const tplId = document.getElementById("tplId");
        const tplList = document.getElementById("tplList");
        const totalEl = document.getElementById("totalBudget");
        const descEl = document.getElementById("desc");

        if (!tplInput || !tplId || !tplList) return;

        // helper rupiah
        function rupiah(n) {
            const x = Math.round(Number(n || 0));
            return "Rp " + x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        }

        // bersihkan pilihan saat user mengetik manual
        tplInput.addEventListener("input", () => {
            // begitu user mulai ketik, anggap belum memilih dari list
            tplId.value = "";
            showListFiltered();
        });

        tplInput.addEventListener("focus", () => {
            showListFiltered();
            tplList.style.display = "block";
        });

        document.addEventListener("click", (e) => {
            if (!tplList.contains(e.target) && e.target !== tplInput) {
                tplList.style.display = "none";
            }
        });

        function showListFiltered() {
            const q = (tplInput.value || "").toLowerCase();
            let vis = 0;
            tplList.querySelectorAll("li").forEach((li) => {
                const txt = li.innerText.toLowerCase();
                const ok = txt.includes(q);
                li.style.display = ok ? "" : "none";
                if (ok) vis++;
            });
            tplList.style.display = vis > 0 ? "block" : "none";
        }

        // saat klik dari list → set nilai & fetch detail
        tplList.querySelectorAll("li").forEach((li) => {
            li.addEventListener("click", () => {
                const id = li.dataset.id;
                const name =
                    li
                        .querySelector(".searchable__name")
                        ?.textContent?.trim() || "";

                tplInput.value = name;
                tplId.value = id;
                tplList.style.display = "none";

                fetchTemplateDetail(id);
            });
        });

        function fetchTemplateDetail(id) {
            const raw = tplInput.getAttribute("data-detail-url"); // "/budgets/templates/__ID__/detail"
            if (!raw) return;
            const url = raw.replace("__ID__", String(id)); // reliable replace

            fetch(url, { headers: { "X-Requested-With": "XMLHttpRequest" } })
                .then((r) => r.json())
                .then((json) => {
                    if (!json || json.ok !== true)
                        throw new Error("Invalid JSON");

                    const t = json.template || {};
                    if (totalEl) totalEl.value = rupiah(t.grand_total || 0);

                    // isi deskripsi jika masih kosong
                    if (
                        descEl &&
                        (!descEl.value || descEl.value.trim() === "")
                    ) {
                        descEl.value = t.description || "";
                    }

                    // set radio kategori
                    const on = document.querySelector(
                        'input[name="category"][value="On Air"]'
                    );
                    const off = document.querySelector(
                        'input[name="category"][value="Off Air"]'
                    );
                    if (on && off) {
                        const cat = String(
                            t.category || "Off Air"
                        ).toLowerCase();
                        (cat.includes("on") ? on : off).checked = true;
                    }
                })
                .catch((err) => {
                    console.error("fetchTemplateDetail error:", err);
                });
        }

        // VALIDASI: wajib pilih dari list (bukan ketik manual)
        const form = (function findForm(el) {
            // cari form terdekat yang mengandung tplInput
            let p = tplInput && tplInput.parentElement;
            while (p && p.tagName !== "FORM") p = p.parentElement;
            return p && p.tagName === "FORM"
                ? p
                : document.querySelector("form");
        })();

        if (form) {
            form.addEventListener("submit", (e) => {
                const id = (tplId.value || "").trim();
                if (!id) {
                    e.preventDefault();
                    alert(
                        "Harap pilih Template dari daftar yang muncul (bukan mengetik manual)."
                    );
                    tplInput.focus();
                }
            });
        }

        // Jika halaman reload dan tplId sudah ada → muat ulang total
        if (tplId.value) {
            fetchTemplateDetail(tplId.value);
        }
    })();
})();
