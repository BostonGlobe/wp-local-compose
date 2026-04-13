# Local WordPress Multi-Site Stack Setup

1. **Clone the repo for each site:**
   - Example:
     - ~/Projects/boston.local
     - ~/Projects/bomag.local

2. **Copy and edit the .env file in each clone:**
   - cp .env.example .env
   - Edit DOMAIN and PORT for each site:
     - boston.local: DOMAIN=boston.local, PORT=8443
     - bomag.local: DOMAIN=bomag.local, PORT=8444

3. **Update your /etc/hosts file:**
   - Add lines for each site:
     127.0.0.1 boston.local
     127.0.0.1 bomag.local

4. **Start each stack (in each repo):**
   - podman-compose up -d  # or docker-compose up -d

5. **Access your sites:**
   - https://boston.local:8443
   - https://bomag.local:8444

6. **Certificates:**
   - Self-signed certs are generated per stack for the specified DOMAIN.
   - You may need to trust the cert in your browser for each .local domain.

---

**Tip:**
- You can add more sites by repeating the above steps with new clones and unique DOMAIN/PORT values.
- If you want to use a single port for all sites, consider a reverse proxy setup (ask for details).
