Ceci est le module principal du projet ACHATO, il contient les submodules Auth, Castle et File.

#### ACHATO - gestion de location de châteaux



#### Prérequis :

- Installer NodeJS
- Installer NPM

Pour initialiser le projet :
```bash
git clone https://github.com/thibautfgi/Achato.git
```

Pour mettre a jours les submodules. :
```bash
git submodule update --init --recursive
```

Architecture du projet :
```md
Frontend ──► Achato-auth (3000) ──► JWT Token
│
▼
┌──────┴──────┐
▼             ▼
Achato-castle   Achato-file
(4004)         (4003)
│             │
└─────────────┘
Service Token (interne)
```

Chaque submodules possède son readme, voici comment lancer chaque microservice :

- Castle Start: 
```bash
cd Achato-castle && npm run dev
```

- Auth Start: 
```bash
cd Achato-auth && npm start
```

- File Start:
```bash
cd Achato-file && npm run dev
```



