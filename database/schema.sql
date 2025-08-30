CREATE DATABASE IF NOT EXISTS eliteplus;
USE eliteplus;

-- Utilisateurs
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  matricule VARCHAR(20) UNIQUE NOT NULL,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE,
  mot_de_passe VARCHAR(255) NOT NULL,
  role ENUM('admin','professeur','eleve','parent','surveillant') NOT NULL,
  date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Classes
CREATE TABLE IF NOT EXISTS classes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL
);

-- Matières
CREATE TABLE IF NOT EXISTS subjects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  coefficient INT DEFAULT 1
);

-- Élèves (profil étendu)
CREATE TABLE IF NOT EXISTS students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  classe_id INT,
  date_naissance DATE,
  sexe ENUM('M','F'),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (classe_id) REFERENCES classes(id) ON DELETE SET NULL
);

-- Lien Classe-Matière-Prof
CREATE TABLE IF NOT EXISTS class_subjects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  class_id INT NOT NULL,
  subject_id INT NOT NULL,
  teacher_id INT NOT NULL,
  UNIQUE KEY uniq_cst (class_id, subject_id),
  FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
  FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Notes
CREATE TABLE IF NOT EXISTS grades (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  subject_id INT NOT NULL,
  trimestre ENUM('1','2','3') NOT NULL,
  note DECIMAL(5,2) NOT NULL,
  appreciation TEXT,
  date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

-- Absences
CREATE TABLE IF NOT EXISTS absences (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  date_absence DATE NOT NULL,
  motif VARCHAR(255),
  justifie BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Discipline
CREATE TABLE IF NOT EXISTS discipline (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  date_incident DATE NOT NULL,
  description TEXT,
  sanction VARCHAR(255),
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Finances
CREATE TABLE IF NOT EXISTS fees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  montant DECIMAL(10,2) NOT NULL,
  type ENUM('inscription','mensualite','autre') NOT NULL,
  statut ENUM('paye','non_paye') DEFAULT 'non_paye',
  date_paiement DATE,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Messages privés
CREATE TABLE IF NOT EXISTS messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  expediteur_id INT NOT NULL,
  destinataire_id INT NOT NULL,
  objet VARCHAR(255),
  contenu TEXT,
  date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  lu BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (expediteur_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (destinataire_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Annonces
CREATE TABLE IF NOT EXISTS annonces (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titre VARCHAR(255) NOT NULL,
  contenu TEXT,
  date_publication TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  auteur_id INT NOT NULL,
  FOREIGN KEY (auteur_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Emploi du temps
CREATE TABLE IF NOT EXISTS emplois_du_temps (
  id INT AUTO_INCREMENT PRIMARY KEY,
  class_id INT NOT NULL,
  subject_id INT NOT NULL,
  teacher_id INT NOT NULL,
  jour ENUM('Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi') NOT NULL,
  heure_debut TIME NOT NULL,
  heure_fin TIME NOT NULL,
  salle VARCHAR(50),
  FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
  FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
);
