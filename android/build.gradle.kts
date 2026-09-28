// Fichier build.gradle au niveau du projet

// Configuration des dépôts pour tous les projets
allprojects {
    repositories {
        google() // Dépôt Google pour les bibliothèques Android
        mavenCentral() // Dépôt Maven Central pour d'autres dépendances
    }
}

// Définition d'un nouveau répertoire de construction
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build") // Chemin relatif pour le répertoire de construction
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

// Configuration des sous-projets
subprojects {
    // Redirige le répertoire de construction pour chaque sous-projet
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Optionnel : dépendance d'évaluation sur le projet ":app"
    project.evaluationDependsOn(":app")
}

// Tâche de nettoyage pour supprimer le répertoire de construction
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory) // Supprime le répertoire de construction
}

