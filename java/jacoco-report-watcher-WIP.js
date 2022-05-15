// Watch target/jacoco.exec, and when changed run the Jacoco Maven Plugin report goal
// Maven project to run on can either be passed in, else it will run on current directory
//
// Wishlist:
// [] Use Jacoco CLI instead of maven (less overhead than using maven)
// [] Option to watch jacoco.exec in all child maven or gradle modules
// [] Run via VS Code Task

var fs = require('fs')
var child_process = require('child_process')

const projectPath = (process.argv.length >= 3 ? process.argv[2] : process.cwd());
const debounceMs = 3000;
let fsTimeout = null;

const jacocoExecPath = projectPath + '/target/jacoco.exec';

if (!fs.existsSync(jacocoExecPath)) {
  console.error("ERROR! " + jacocoExecPath + " does not exist");
  process.exit(1)
}

runJacocoReport()
console.log("Watching " + jacocoExecPath + " ...")
fs.watch(jacocoExecPath, function () {
    if (fsTimeout) clearTimeout(fsTimeout)
    fsTimeout = setTimeout(runJacocoReport, debounceMs)
})

function runJacocoReport() {
    child_process.spawn(
        'mvn', ['org.jacoco:jacoco-maven-plugin:report', '-f', projectPath], 
        { stdio: 'inherit' }
    )
}
