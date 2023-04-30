const Formats = {
    category: `
        <div>
            <div>
                <div>
                    <span>$[LABEL]</span>
                    <div>
                        <span>Level $[LEVEL]</span>
                        <span>XP $[XP] / $[LEVEL_XP]</span>
                    </div>
                </div>
                <div class="progress-bar">
                    <div class="progress-value" style="width: $[PROGRESS]%"></div>
                </div>
            </div>
        </div>
    `,
}

let categories;

function post(type, data) {
    fetch(`https://pickle_xp/${type}`, {
        method: 'post',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data || {})
    })
    .then(response => {  })
    .catch(error => {  });
}

function DisplayXP(data) {
    categories = data;
    let categoriesHtml = "";
    for (const [key, value] of Object.entries(categories)) {
        let category = value
        let xpHtml = Formats.category;
        let xp = (category.xp > category.level_xp ? category.level_xp : category.xp)
        xpHtml = xpHtml.replaceAll("$[LABEL]", category.label)
        xpHtml = xpHtml.replaceAll("$[LEVEL]", category.level)
        xpHtml = xpHtml.replaceAll("$[XP]", xp)
        xpHtml = xpHtml.replaceAll("$[LEVEL_XP]", category.level_xp)
        xpHtml = xpHtml.replaceAll("$[PROGRESS]", Math.ceil((xp / category.level_xp) * 100))
        categoriesHtml += xpHtml;
    }
    $("#middle").html(categoriesHtml);
    $("#container").css("display", "flex").hide().fadeIn();
}

function HideSkills() {
    $("#container").fadeOut();
}

$(document).ready(function () {
    console.log("HELLO2")
    $(document).on("click", ".exit", function(event) {
        HideSkills()
        post("hide")
    })
})

window.addEventListener("message", function(ev) {
    var event = ev.data
    console.log("HELLO")
    if (event.type == "show") {
        DisplayXP(event.data)
    }
    else if (event.type == "hide") {
        HideSkills()
    }
})