Untuk menjalankan server:

1. Install NodeJS
    Download: https://nodejs.org/en
2. Install json-server
    Run Command: sudo npm i -g json-server
3. Jalankan server
    json-server --watch assets/db.json
4. Jalan ini jika mau running di emulator
    adb reverse tcp:3000 tcp:3000