Project Overview - This project is a rental car management database built for MIS 440.
It includes schema scripts, sample data, and documentation for creating and testing the database in SQL Server Management Studio (SSMS).
---
Contributors: Miguel Sumo, Nawal Diriye, Evan Buckingham, Omar Farouk
---

440DatabaseProject/
├── app/                 # PHP web app (rename current 440/ here)
│   ├── public/          # index.php, CSS, JS, assets
│   ├── includes/        # shared PHP includes
│   └── config/          # db connection, config files
│
├── db/                  # all database-related code
│   ├── sqlserver/       # SSMS scripts
│   │   ├── 01_schema/
│   │   ├── 02_seed/
│   │   ├── 03_views/
│   │   └── 04_procs_triggers/
│   └── mysql/           # MySQL versions if needed
│       ├── 01_schema/
│       ├── 02_seed/
│       ├── 03_views/
│       └── 04_procs_triggers/
│
├── docs/                # project documentation
│   ├── erd/             # ERD images / PDFs
│   ├── requirements/    # business rules, narrative
│   └── deliverables/    # instructor rubrics, final write-up, etc.
│
├── .gitignore
├── update_and_push.bat
└── README.md

