Pour mettre a jours les submodules. :
```bash
git submodule update --init --recursive
```

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
