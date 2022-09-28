git clone https://github.com/zavden/docs-static.git docs
git clone https://github.com/zavden/docs-static.git
rm -rf docs/.git
rm -rf docs-static/.git
mkdir -p src/ejercicios/ docs/ejercicios/ templates/ejemplo src/markdown/
mkdir -p templates/markdown docs/markdown/ src/static src/static/diagrams src/static/screenshots src/static/txt draws/ 
mkdir -p modules/pug/blocks modules/pug/functions modules/pug/mixins modules/pug/static
mv docs-static modules
npm install --save-dev jstransformer-markdown-it pug-cli typescript live-server sass jstransformer-highlight
echo 'node_modules/' > .gitignore
# Templates
echo '-
    const n_ej = 1

    const range = (start, end) => {
        if(start >= end) return [start]
        return [start, ...range(start + 1, end)]
    }
    const zeroPad = (num, places) => String(num).padStart(places, 0)

    const list_ej = range(1,n_ej)
    let lista_ejercicios = []
    list_ej.forEach(e => lista_ejercicios.push(zeroPad(e,2)))

    const zip_arrs = (arr1, arr2) =>{
        const new_arr = []
        for(let i=0; i<arr1.length; i++){
            let ar = [arr1[i], arr2[i]]
            new_arr.push(ar)
        }
        return new_arr
    }
' > modules/pug/functions/functions.pug
echo 'extends /modules/pug/blocks/ejercicios
block pug_javascript
    -
        let titulo = "Ejemplo NL",
            formato = ""
        let codepen_list = [
            "vYEPxPX",
            "BaybRKr",
        ]
        nej = NL // <== EXERCISE NUMBER - REPLACE IT
block pug_styles
    +new_style(`../styles.css`)
block html_javascript
    +new_script(`../scripts.js`)
block pug_contenido
    +codepen_flex_all("BaybRKr")
    +codepen_flex_all("vYEPxPX")
    hr
    +code_emb_source_u("ej-01")
    +code_emb_source_u("ej-02")
    hr
    +codepen_flex_all("BaybRKr",1)
    +codepen_flex_all("vYEPxPX",1)
    hr
    hr
    +code_emb_html("ej-01")
    +code_emb_css("ej-01")
    +code_emb_js("ej-01")
    br
    +code_html("02", "HTML", "CSS", "JS")
    .tabcontent#HTML-02
        +code_emb_html("ej-02")
    .tabcontent#CSS-02
        +code_emb_css("ej-02")
    .tabcontent#JS-02
        +code_emb_js("ej-02")
    +img_e("e1-1.png")
    :markdown-it
        ![](../static/e1-1.png)
    //- pre: code.txt-diagram: include ../static/txt-diagrams/diag1.txt
    +code_html("01", "HTML", "CSS", "JS")
    .tabcontent#HTML-01: :markdown-it(html)
            ```html
            <p>Hello world - 3</p>
            ```
    .tabcontent#CSS-01: :markdown-it(html)
            ```css
            p {
                color: green;
            }
            ```
    .tabcontent#JS-01: :markdown-it(html)
            ```javascript
            const d = p.querySelector("d");
            d.style.fontSize = "2em";
            ```
    hr
    hr
    +codepen_flex("BaybRKr",1)
    +codepen_flex_live("BaybRKr",1)
    +codepen_flex_all("BaybRKr",1)
    hr
    +html_emb_ej("ej-01")
    .tab-content
        +tab_info(0, "HTML", "CSS", "JS")
        .tabcontent#HTML-0
            :markdown-it(html)
                ```html
                <p>Hello world</p>
                ```
        .tabcontent#CSS-0
            :markdown-it(html)
                ```css
                p {
                    color: red;
                }
                ```
        .tabcontent#JS-0
            :markdown-it(html)
                ```javascript
                const p = p.querySelector("p");
                p.style.fontSize = "2em";
                ```
    hr
    hr
    +code_html("03", "HTML", "CSS", "JS")
    .tabcontent#HTML-03: pre: code.hljs: :highlight(lang="html")
        <p>Hello world - 3</p>
    .tabcontent#CSS-03
        pre: code.hljs: include:highlight(lang="scss") ../ejemplos/ej-03/styles.scss
    .tabcontent#JS-03
        pre: code.hljs: include:highlight(lang="typescript") ../ejemplos/ej-03/script.ts
    hr
    .content-flex-code
        pre(style="display: block; width:100%"): code.hljs(style="height: 100%"): :highlight(lang="html")
            <p> ABC </p>
        pre(style="display: block; width:100%"): code.hljs(style="height: 100%"): :highlight(lang="css")
            p:target {
                color: red;
            }


' > templates/ejercicios.pug

echo 'doctype
html
    head
        title Ejemplo
        link(rel="stylesheet" href="styles.css")

    body
        // ===============================================
        // Start
        p.title.
            Este es un iframe, debe ser rojo y grande,
            los estilos vienen de SASS.
        p#subtitle.
            Este es un subtítulo, debe ser rosa,
            el estilo debe venir de TS.
        // END
        // ===============================================

        script(src="script.js")
'> templates/ejemplo/index.pug

echo '.title {
    color: red;
    font-size: 2em;
}
'> templates/ejemplo/styles.scss

echo '(function() {
    const subtitle = document.getElementById("subtitle")
    subtitle.style.color= "pink"
})()
'> templates/ejemplo/script.ts
# src files
echo '* {
    box-sizing: border-box;
}
#titulo{
    border: 2px dotted black;
    margin-left: auto;
    text-align: center;
    margin-right: auto;
}
body{
    background: #ff9966; 
    background: linear-gradient(to right, rgba(217,89,0,1), rgba(255,179,107,1));
    font-size: 1.3rem;
    font-family: Arial, Helvetica, sans-serif;
}
.contenido{
    background-color: white;
    min-height: calc( 100vh - 20px );
    max-width: 1262px;
    margin: 0 auto;
    padding: 20px 30px 0 30px;
}
a {
    text-decoration: none;
    color: white;
}
[href^="http"]{
    background-color: red;
    padding: 10px;
    border-radius: 10px 30px;
}
.link-ejercicios{
    background-color: teal;
    padding: 10px;
    border-radius: 10px 30px;
}
.menu-nav{
    display: flex;
    justify-content: center;
    text-align: center;
    & a{
       flex:1;
       background-color: steelblue;
       //padding-top: 20px;
       //padding-bottom: 20px;
       padding: 20px;
    }
    & a:hover {
        background-color: purple;
    }
}
code{
    background-color: rgba(254,209,206,1);
    display: inline-block;
    font-size: 0.9em;
    padding: 0.2rem 0.2rem;
    border: thin solid red;
    pre & {
        background-color: black;
        color:white;
        display:block;
        padding: 20px 40px;
        border: thin dotted black;
        border-radius: 0;
    }
}
.header{
    background-color: #fb6f66;
    border-radius: 0;
    font-size:2.5rem
}
.formula {
    font-size: 150%;
}
.ejercicio {
    font-size: 140%;
    font-weight: bold;
    margin-top: 0.83em;
    margin-bottom: 0.83em;
    margin-left: 0;
    margin-right: 0;
}
img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    min-width: 45em;
}
// -----------------

#write {
    counter-reset: h1
}

h1 {
    counter-reset: h2
}

h2 {
    counter-reset: h3
}

h3 {
    counter-reset: h4
}

h4 {
    counter-reset: h5
}

h5 {
    counter-reset: h6
}

/** put counter result into headings */
h1:before {
    counter-increment: h1;
}

h2:before {
    counter-increment: h2;
    content: counter(h2) ". "
}

h3:before,
h3.md-focus.md-heading:before /** override the default style for focused headings */ {
    counter-increment: h3;
    content: counter(h2) "." counter(h3) ". "
}

h4:before,
h4.md-focus.md-heading:before {
    counter-increment: h4;
    content: counter(h2) "." counter(h3) "." counter(h4) ". "
}

h5:before,
h5.md-focus.md-heading:before {
    counter-increment: h5;
    content: counter(h2) "." counter(h3) "." counter(h4) "." counter(h5) ". "
}

h6:before,
h6.md-focus.md-heading:before {
    counter-increment: h6;
    content: counter(h2) "." counter(h3) "." counter(h4) "." counter(h5) "." counter(h6) ". "
}

/** override the default style for focused headings */
h3.md-focus:before,
h4.md-focus:before,
h5.md-focus:before,
h6.md-focus:before,
h3.md-focus:before,
h4.md-focus:before,
h5.md-focus:before,
h6.md-focus:before {
    color: inherit;
    border: inherit;
    border-radius: inherit;
    position: inherit;
    left:initial;
    float: none;
    top:initial;
    font-size: inherit;
    padding-left: inherit;
    padding-right: inherit;
    vertical-align: inherit;
    font-weight: inherit;
    line-height: inherit;
}
// -----------------
// -----------------
pre code.hljs{display:block;overflow-x:auto;padding:1em}
code.hljs{padding:3px 5px}.hljs{background:#272822;color:#ddd}
.hljs-keyword,.hljs-literal,.hljs-name,.hljs-selector-tag,.hljs-strong,.hljs-tag{color:#f92672}
.hljs-code{color:#66d9ef}.hljs-attribute,.hljs-link,.hljs-regexp,.hljs-symbol{color:#bf79db}
.hljs-addition,.hljs-built_in,.hljs-bullet,.hljs-emphasis,.hljs-section,.hljs-selector-attr,.hljs-selector-pseudo,.hljs-string,.hljs-subst,.hljs-template-tag,.hljs-template-variable,.hljs-title,.hljs-type,.hljs-variable{color:#a6e22e}
.hljs-class .hljs-title,.hljs-title.class_{color:#fff}
.hljs-comment,.hljs-deletion,.hljs-meta,.hljs-quote{color:#75715e}
.hljs-doctag,.hljs-keyword,.hljs-literal,.hljs-section,.hljs-selector-id,.hljs-selector-tag,.hljs-title,.hljs-type{font-weight:700}
// -----------------
.embed-container {
    position: relative;
     /* set the aspect ratio here as (height / width) * 100% */
    height: 0;
    overflow: hidden;
    max-width: 100%;
}
   
.embed-container iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.html-resize {
    resize: both;
    overflow: auto;
    border: solid gray;
    border-width: thin;
}

.menu-nav .remark-ej{
    background-color: lightseagreen;
}

.tab {
    overflow: hidden;
    border: 1px solid #ccc;
    background-color: #f1f1f1;
  }
  
  /* Style the buttons that are used to open the tab content */
  .tab button {
    background-color: inherit;
    float: left;
    border: none;
    outline: none;
    cursor: pointer;
    padding: 14px 16px;
    transition: 0.3s;
  }
  
  /* Change background color of buttons on hover */
  .tab button:hover {
    background-color: #ddd;
  }
  
  /* Create an active/current tablink class */
  .tab button.active {
    background-color: #ccc;
  }
  
  /* Style the tab content */
  .tabcontent {
    display: none;
    padding: 6px 12px;
    border: 1px solid #ccc;
    border-top: none;
  }

.change-vh-container {
    text-align: right;
}

.ejercicio-html{
    background-color: purple;
    padding: 10px;
    border-radius: 10px 30px;
}

.super-embed-container .change-vh-container{
    padding-bottom: 50px;
    background-color: #1D1E22;
    color: white;
}


.content-flex-code {
    display: flex;
    align-items: stretch;
    align-content: center;
}
' > src/styles.scss
echo 'extends /modules/pug/blocks/index
block pug_javascript
    -
        let titulo = "INDEX",
            formato = "CSS-A-"
block pug_styles
    +new_style(`styles.css`)
block html_javascript
    +new_script(`scripts.js`)
block pug_contenido
    +ejercicios("01","Animaciones básicas")
    :markdown-it(html)
        ## Este es un título.

        ## Esto es cóigo de bloque:
        ```python
        from manimlib.imports import *
        self.play(Write("Hola mundo"))
        ```

        Esto es un `codigo` en linea.

        ## Esta es una fórmula
        $$\Large
            \lim_{n\to\infty}\sum_{i=0}^{n}f\left(a+\frac{i(b-a)}{n}\right)\left(\frac{b-a}{n}\right) = \int_a^b f(x)
        $$

        Esta es una imagen:
        ![Ejemplo](./static/e1-1.png)
' > src/index.pug

# docs
echo 'document.addEventListener("DOMContentLoaded", (event) => {
    const titulo = document.getElementById("titulo")
    titulo.style.color = "red"
    titulo.addEventListener("click",()=>alert("Hiciste click en el título"))

    const all_codepen_flex = document.querySelectorAll(".ejercicio-flex")
    const changeVal = (checkBox : HTMLInputElement, ret: number = 1) => {
      if(checkBox.checked) return ret
      return 0
    }
    const changeState = (_val: number, idCodeFlex: HTMLInputElement) => {
      if(_val === 0) {idCodeFlex.style.resize = "none"}
      if(_val === 1) {idCodeFlex.style.resize = "vertical"}
      if(_val === 2) {idCodeFlex.style.resize = "horizontal"}
      if(_val === 3) {idCodeFlex.style.resize = "both"}
    }
    all_codepen_flex.forEach( (code_flex) => {
      const idCodeFlex = code_flex.id
      const checkBoxVertical   = document.getElementById(`${idCodeFlex}-v`) as HTMLInputElement
      const checkBoxHorizontal = document.getElementById(`${idCodeFlex}-h`) as HTMLInputElement
      const widthPrinter       = document.getElementById(`${idCodeFlex}-width`) as HTMLElement
      const heightPrinter      = document.getElementById(`${idCodeFlex}-height`) as HTMLElement
      const resizeFrame        = document.getElementById(`${idCodeFlex}-iframe`) as HTMLIFrameElement
      const iframeContainer    = document.getElementById(`${idCodeFlex}-iframe-container`)

      if(resizeFrame !== null){
        iframeContainer.addEventListener("mousemove", (e) => {
          widthPrinter.innerText  = `${resizeFrame.clientWidth}`
          heightPrinter.innerText = `${resizeFrame.clientHeight}`
        })
      }


      checkBoxVertical.addEventListener("click", e => {
        const _val = changeVal(e.target as HTMLInputElement, 1) + changeVal(checkBoxHorizontal, 2)
        changeState(_val, code_flex as HTMLInputElement)
      })
      checkBoxHorizontal.addEventListener("click", e => {
        const _val = changeVal(e.target as HTMLInputElement, 2) + changeVal(checkBoxVertical, 1)
        changeState(_val, code_flex as HTMLInputElement)
      })
    })

    const all_iframes_container = document.querySelectorAll(".iframe-container")

    all_iframes_container.forEach(e => {
      const frameId       = e.id.slice(0,"ej-00".length)
      const widthPrinter  = document.getElementById(`${frameId}-width`)
      const heightPrinter = document.getElementById(`${frameId}-height`)
      const resizeFrame   = document.getElementById(`${frameId}-iframe`)

      if(resizeFrame !== null){
        e.addEventListener("mousemove", (e) => {
          widthPrinter.innerText  = `${resizeFrame.clientWidth}`
          heightPrinter.innerText = `${resizeFrame.clientHeight}`
        })
      }
    })
})

function openTAB(evt: Event, cityName: string) {
    // Declare all variables
    var i, tablinks;
  
    // Get all elements with class="tabcontent" and hide them
    let tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
      (tabcontent[i] as HTMLElement).style.display = "none";
    }
  
    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
  
    // Show the current tab, and add an "active" class to the button that opened the tab
    document.getElementById(cityName).style.display = "block";
    // evt.target.classList.toggle("active");
    (evt.target as HTMLElement).classList.toggle("active");
  }


' > src/scripts.ts

# modules
#-------------PUG
#-------------------INDEX
echo 'include /modules/pug/functions/functions
include /modules/pug/mixins/mixins
block pug_javascript
doctype
html
    head
        title=`${titulo}`
        include /modules/pug/static/meta_static
        block pug_styles
        link(rel="stylesheet" href="prism/prism.css")
        link(rel="icon" href="favicon.ico")
    body
        .contenido
            h1#titulo=`${titulo}`
            .menu-nav
                a(href="#downer").remark-ej=`Index`
                +menu_nav_index(...lista_ejercicios)
            block pug_contenido
            hr
            .menu-nav#downer
                a(href="#titulo").remark-ej=`Index`
                +menu_nav_index(...lista_ejercicios)
        block html_javascript
        include /modules/pug/static/js_static
        script(src="prism/prism.js")
' > modules/pug/blocks/index.pug
#-------------------EJERCICIO
echo 'include /modules/pug/functions/functions
include /modules/pug/mixins/mixins
block pug_javascript
- let code_count = 0
- let codepen_count = 0
doctype
html
    head
        title=`${titulo}`
        include /modules/pug/static/meta_static
        block pug_styles
        link(rel="stylesheet" href="../prism/prism.css")
        link(rel="icon" href="../favicon.ico")
        script(src="../static/hl.js")
        script.
            const getSourceCode = async(name, _file) => {
                const response = await fetch(`../ejemplos/${name}/${_file}`);
                const _html    = await response.text();
                return _html
            }
            const replace_all_codes = async (e, _file) => {
                let _name = e.innerText;
                let _html = await getSourceCode(_name, _file);
                let code = hljs.highlightAuto(_html).value;
                e.innerHTML = code
            }
            let all_codes;
    body
        .contenido
            h1#titulo=`${titulo}`
            .menu-nav
                a(href="../index.html")=`Index`
                +menu_nav(...lista_ejercicios)
            code.header(style="text-align:center; display:block")
                a(href="#downer")=`${formato}`
            block pug_contenido
            hr
            code.header(style="text-align:center; display:block")
                a(href="#titulo")=`${formato}`
            .menu-nav#downer
                a(href="../index.html")=`Index`
                +menu_nav(...lista_ejercicios)
        block html_javascript
        include /modules/pug/static/js_static
        script(src="../prism/prism.js")
' > modules/pug/blocks/ejercicios.pug


echo '//- include /modules/pug/functions/functions
-
    let title = undefined,
        codepen_user = "zavden"
mixin codepen(index,height_window=310,user=codepen_user)
    -let url = codepen_list[index-1]
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${index}`
    p(class="codepen" data-height=`${height_window}` 
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)


mixin codepen_iframe(url, height=400, user=codepen_user)
    iframe(height=`${height}` style="width: 100%;" scrolling="no" src=`https://codepen.io/${user}/embed/${url}?default-tab=result` frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true") See the Pen

mixin codepen_url(url,text="",height_window=310,user=codepen_user,editable="true")
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${text}`
    p(class="codepen" data-height=`${height_window}` 
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)
mixin ejercicios(url,nombre="",explicacion="")
    .ejercicio #[a(href=`ejercicios/ejercicios-${url}.html` class="link-ejercicios")=`Ejercicio ${url}`]#[span=` - ${nombre}`] 
        p=`${explicacion}`
mixin new_style(url)
    link(rel="stylesheet" href=url)
mixin new_script(url)
    script(src=url)
mixin menu_nav(...arr_ejercicios)
    each ej in arr_ejercicios
        if ej == nej
            if title === undefined
                a(href=`ejercicios-${ej}.html`).remark-ej=`Ej-${ej}`
            else
                a(href=`ejercicios-${ej}.html`).remark-ej=`${title}`
        else
            if title === undefined
                a(href=`ejercicios-${ej}.html`)=`Ej-${ej}`
            else
                a(href=`ejercicios-${ej}.html`)=`${title}`
mixin menu_nav_index(...arr_ejercicios)
    each ej in arr_ejercicios
        if ej == nej
            if title === undefined
                a(href=`ejercicios/ejercicios-${ej}.html`).remark-ej=`Ej-${ej}`
            else
                a(href=`ejercicios/ejercicios-${ej}.html`).remark-ej=`${title}`
        else
            if title === undefined
                a(href=`ejercicios/ejercicios-${ej}.html`)=`Ej-${ej}`
            else
                a(href=`ejercicios/ejercicios-${ej}.html`)=`${title}`
mixin html_emb_ej(name,padding="300px")
    .embed-container(style=`padding-bottom: ${padding};`).html-resize
        iframe.html-resize(src=`../ejemplos/${name}/` frameborder="0" allowfullscreen)
mixin html_emb(name,padding="300px")
    .embed-container(style=`padding-bottom: ${padding};`).html-resize
        iframe.html-resize(src=name frameborder="0" allowfullscreen)
mixin img(src)
    img(src=`./static/${src}` style=`width: 100%`)
mixin img_path(src)
    img(src=`${src}` style=`width: 100%`)
mixin img_e(src)
    img(src=`../static/${src}` style=`width: 100%`)
mixin md_emb(number,padding="1000px")
    .embed-container(style=`padding-bottom: ${padding};`).html-resize
        iframe.html-resize(src=`../markdown/md-${number}.html` frameborder="0" allowfullscreen)

mixin codepen_live(index,height_window=310,user=codepen_user)
    -let url = codepen_list[index-1]
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${index}`
    p(class="codepen" data-height=`${height_window}` 
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      data-editable="true"
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)
mixin codepen_url_live(url,text="",height_window=310,user=codepen_user,editable="true")
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${text}`
    p(class="codepen" data-height=`${height_window}` 
      data-editable="true"
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)

mixin tab_info(_id=0,...all_tabs)
    .tab
        each _tab in all_tabs
            button(class="tablinks" onclick=`openTAB(event, "${_tab}-${_id}")`)=`${_tab}`

mixin codepen_flex(url,text="",format="result",height_window=450,user=codepen_user)
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${text}`
    .embed-container.ejercicio-flex(style=`padding-bottom: ${height_window}px;` id=url).html-resize
        p(class="codepen" data-height=`${height_window}` 
        data-theme-id="default" data-default-tab=format 
        data-user=user data-slug-hash=`${url}`
        style=`height: ${height_window}px; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)
    .change-vh-container
        form
            input(
                type="checkbox" id=`${url}-v` name=`${url}-v`
                value="vertical"
            )
            label(for=`${url}-v`) Vertical
            input(
                type="checkbox" id=`${url}-h` name=`${url}-h`
                value="vertical"
            )
            label(for=`${url}-h`) Horizontal

mixin codepen_flex_live(url,text="",format="result",height_window=450,user=codepen_user)
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${text} - live`
    .embed-container.ejercicio-flex(style=`padding-bottom: ${height_window}px;` id=url).html-resize
        iframe(
            height=`${height}` style="width: 100%;" scrolling="no" title="CSS-A-2"
            src=`https://codepen.io/${user}/embed/${url}?default-tab=result`
            frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true"
        ) See the Pen
    .change-vh-container
        form
            input(
                type="checkbox" id=`${url}-v` name=`${url}-v`
                value="vertical"
            )
            label(for=`${url}-v`) Vertical
            input(
                type="checkbox" id=`${url}-h` name=`${url}-h`
                value="vertical"
            )
            label(for=`${url}-h`) Horizontal

mixin code_html(num, ...blks)
    .ejercicio
        a(href=`../ejemplos/ej-${zeroPad(num,2)}/index.html` target="_blank").ejercicio-html=`Ejercicio ${num}`
    +html_emb_ej(`ej-${num}`)
    .tab-content
        +tab_info(num, ...blks)

mixin codepen_flex_all(url,format="html",height_window=450,user=codepen_user)
    - codepen_count += 1
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${zeroPad(codepen_count,2)}`
    .super-embed-container(id=`${url}-iframe-container`)
        .embed-container.ejercicio-flex(style=`padding-bottom: ${height_window}px;` id=url).html-resize
            iframe(
            height=`${height}` style="width: 100%;" scrolling="no" id=`${url}-iframe`
            src=`https://codepen.io/${user}/embed/${url}?default-tab=result`
            frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true"
        ) See the Pen
        .change-vh-container
            form
                p(style="display: inline-block") Width = 
                    span(id=`${url}-width`).width-printer 0
                p(style="display: inline-block") Height = 
                    span(id=`${url}-height`).width-printer 0
                input(
                    type="checkbox" id=`${url}-v` name=`${url}-v`
                    value="vertical"
                )
                label(for=`${url}-v`) Vertical
                input(
                    type="checkbox" id=`${url}-h` name=`${url}-h`
                    value="vertical"
                )
                label(for=`${url}-h`) Horizontal
    .embed-container.ejercicio-flex(style=`padding-bottom: ${height_window}px;` id=`${url}A`).html-resize
        p(class="codepen" data-height=`${height_window}` 
        data-theme-id="default" data-default-tab=format
        data-user=user data-slug-hash=`${url}`
        style=`height: ${height_window}px; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em; font-size=2em`)
    .change-vh-container
        form
            input(
                type="checkbox" id=`${url}A-v` name=`${url}A-v`
                value="vertical"
            )
            label(for=`${url}A-v`) Vertical
            input(
                type="checkbox" id=`${url}A-h` name=`${url}A-h`
                value="vertical"
            )
            label(for=`${url}A-h`) Horizontal

mixin code_emb_html(name,padding="300px")
    pre(id=`${name}-html`)
        code.html-resize.embed-container(style=`padding-bottom: ${padding};` class=`language-html`).hljs.code-emb=`${name}`
    script all_codes = document.querySelectorAll("#!{name}-html .language-html")
    script.
        for(let _i=0; _i<all_codes.length; _i++){
            replace_all_codes(all_codes[_i], "index.html")
        }

mixin code_emb_css(name,padding="300px")
    pre(id=`${name}-css`)
        code.html-resize.embed-container(style=`padding-bottom: ${padding};` class=`language-css`).hljs.code-emb=`${name}`
    script all_codes = document.querySelectorAll("#!{name}-css .language-css")
    script.
        for(let _i=0; _i<all_codes.length; _i++){
            replace_all_codes(all_codes[_i], "styles.css")
        }

mixin code_emb_js(name,padding="300px")
    pre(id=`${name}-javascript`)
        code.html-resize.embed-container(style=`padding-bottom: ${padding};` class=`language-javascript`).hljs.code-emb=`${name}`
    script all_codes = document.querySelectorAll("#!{name}-javascript .language-javascript")
    script.
        for(let _i=0; _i<all_codes.length; _i++){
            replace_all_codes(all_codes[_i], "script.js")
        }

mixin code_emb_source(name, padding="300px", padding_code="400px")
    - code_count += 1
    .ejercicio
        a(href=`../ejemplos/${name}/index.html` target="_blank").ejercicio-html=`Ejercicio - ${name.slice(3)}`
    .embed-container(style=`padding-bottom: ${padding};`).html-resize
        iframe(src=`../ejemplos/${name}/` frameborder="0" allowfullscreen)
    .tab-content
        +tab_info(code_count, "HTML-S", "CSS-S", "JS-S")
        .tabcontent(id=`HTML-S-${code_count}`)
            +code_emb_html(name, padding=padding_code)
        .tabcontent(id=`CSS-S-${code_count}`)
            +code_emb_css(name, padding=padding_code)
        .tabcontent(id=`JS-S-${code_count}`)
            +code_emb_js(name, padding=padding_code)


mixin code_emb_source_u(name, padding="300px", padding_code="400px")
    - code_count += 1
    .ejercicio
        a(href=`../ejemplos/${name}/index.html` target="_blank").ejercicio-html=`Ejercicio iframe - ${name.slice(3)}`
    .iframe-container(id=`${name}-iframe-container`)
        .numbers-container(style="margin-bottom: -20px")
            p(style="display: inline-block") Width = 
                span(id=`${name}-width`).width-printer 0
            p(style="display: inline-block") ; Height = 
                span(id=`${name}-height`).width-printer 0
        .embed-container(style=`padding-bottom: ${padding};`).html-resize
            iframe(src=`../ejemplos/${name}/` frameborder="0" allowfullscreen id=`${name}-iframe`)
        .tab-content
            +tab_info(code_count, "HTML-S", "CSS-S", "JS-S")
            .tabcontent(id=`HTML-S-${code_count}`)
                +code_emb_html(name, padding=padding_code)
            .tabcontent(id=`CSS-S-${code_count}`)
                +code_emb_css(name, padding=padding_code)
            .tabcontent(id=`JS-S-${code_count}`)
                +code_emb_js(name, padding=padding_code)



' > modules/pug/mixins/mixins.pug
echo 'script(async src="https://static.codepen.io/assets/embed/ei.js")
script(defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.js" integrity="sha384-y23I5Q6l+B6vatafAwxRu/0oK/79VlbSz7Q9aiSZUvyWYIYsd+qj+o24G5ZU2zJz" crossorigin="anonymous")
script(defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous")
script.
    document.addEventListener("DOMContentLoaded", function() {
        renderMathInElement(document.body, {
              delimiters: [
                  {left: "$$", right: "$$", display: true},
                  {left: "\\[", right: "\\]", display: true},
                  {left: "$", right: "$", display: false},
                  {left: "\\(", right: "\\)", display: false}
              ]
        });
    });
' > modules/pug/static/js_static.pug

echo 'meta(cjarset="UTF-8")
meta(name="viewport" content="width=device-width, initial-scale=1.0")
meta(http-equiv="X-UA-Compatible" content="ie=edge")
link(rel="stylesheet" href="https://necolas.github.io/normalize.css/8.0.0/normalize.css")
link(rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.css" integrity="sha384-zB1R0rpPzHqg7Kpt0Aljp8JPLqbXI3bhnPWROx27a9N0Ll6ZP/+DiW/UqRcLbRjq" crossorigin="anonymous")
' > modules/pug/static/meta_static.pug

echo '
{
  "compilerOptions": {
    "target": "ES2018",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "strictNullChecks":false,
    "forceConsistentCasingInFileNames": true, 
    "outDir": "docs/",
    "rootDir": "src/",
  },
  "exclude": ["templates","node_modules", "**/*.spec.ts"],
}
' > tsconfig.json

echo '<p style="text-decoration-line: underline overline; text-align:center; font-size: 4em; text-underline-offset: 20px"> Título</p>

# Primer titulo

![imagen](../static/e1-1.png)
' > templates/markdown/md.md

echo '-
    const n_ej = NE

    const range = (start, end) => {
        if(start >= end) return [start]
        return [start, ...range(start + 1, end)]
    }
    const zeroPad = (num, places) => String(num).padStart(places, 0)

    const list_ej = range(1,n_ej)
    let lista_ejercicios = []
    list_ej.forEach(e => lista_ejercicios.push(zeroPad(e,2)))

    const zip_arrs = (arr1, arr2) =>{
        const new_arr = []
        for(let i=0; i<arr1.length; i++){
            let ar = [arr1[i], arr2[i]]
            new_arr.push(ar)
        }
        return new_arr
    }
' > templates/functions.pug

#----------------
make next-e
make next-e
make next-e
make next-h
make next-h
make next-h
make init
