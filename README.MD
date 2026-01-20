Pour mettre a jours les submodules. :
```bash
git submodule update --init --recursive
```

Frontend ──► Achato-auth (4001) ──► JWT Token
│
▼
┌──────┴──────┐
▼             ▼
Achato-castle   Achato-file
(4004)         (4003)
│             │
└─────────────┘
Service Token (interne)