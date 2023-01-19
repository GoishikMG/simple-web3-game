async function App() {
    const template = document.createElement('template')
    template.innerHTML = `
        <div class="container">
            <p>Hello world</p>
        </div>
    `
    return template.content.cloneNode(true)
}

export default App;