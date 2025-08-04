# Monitoring containers

The goal of this project is to use it inside coolify as a monitoring system.

There are two version :

- <a href="#heavy">Heavy</a>
- <a href="#light">Light</a>

Both versions are Docker Compose-based and should be deployed via an application in the Coolify UI.

> ⚠️ **By default, both setups store monitoring data for 7 days.**  
> You can easily adjust this by editing their respective configuration files.

> 💡 Use the **heavy version** only if you need advanced dashboards, alerting, or custom metrics collection (e.g., for a large-scale app or company).  
> Otherwise, the **light version is recommended** for most small to medium-sized projects.

## <span id="#heavy">Heavy</span>

### Resources

It uses the following :

- Prometheus (to gather the data)
    - node-exporter (to get system informations)
    - cadvisor (to get docker containers informations)
- Grafana (to have a dashboard, alerting system and other functionalities)

**Here are the values for system comsuption :**

```
RAM used :
    - Prometheus (300–600 MB)
    - Grafana (100–200 MB MB)
```

### Installation

1. Deploy the `docker-compose.heavy.yaml` using a Coolify application.
2. Once deployed, open your Grafana domain.

Go to your grafana page.
connect using the default login + password
- **user:** admin
- **pass:** admin
(You’ll be asked to change it on first login.)

---

#### Data source setup

1. In Grafana, go to: `Connections > Data sources`
2. Add a new **Prometheus** source with the following URL:
    http://prometheus:9090
3. Click **Save & Test**.

#### Dashboards

Instead of manually building dashboards, you can **import prebuilt ones**:

- **ID `193`**: Docker + System monitoring (cAdvisor)
- **ID `1860`**: Full system monitoring (Node Exporter)

Use these in Grafana under:  
`Dashboards > Import`

#### 🌐 HTTPS / Domain Setup

To enable HTTPS via Coolify (Traefik):

- Set your subdomain and configure DNS
- Update the environment variable `CREATED_GRAFANA_HOST` in `docker-compose.heavy.yaml`

---

#### Other functionality

Grafana can:
- Send alerts to Discord, Slack, email, etc.
- Schedule weekly reports with resource usage
- Create thresholds and receive live notifications

## <span id="#light">Light</span>

### Resources

It uses the following :

- **Netdata**: All-in-one lightweight monitoring tool (includes dashboard, metrics, and alerts)

**Here are the values for system comsuption :**

```
RAM used : 150–200 MB
```


---

### 🚀 Installation

1. Deploy the `docker-compose.light.yaml` using a Coolify application.
2. Configuration files are in the `config/` folder.

#### 📁 Notification Setup

To enable Discord alerts:
- Edit `config/health/health_alarm_notify.conf`
- Set your `DISCORD_WEBHOOK_URL`

#### 📁 Disk Usage Alert

A preconfigured alert in `disk_usage.conf` is included.  
It triggers when disk usage exceeds **80%**, and sends a Discord notification.

---

### 🔒 Accessing the Dashboard (localhost only)

The Netdata dashboard is **not publicly exposed** for security reasons.

To access it:

```bash
ssh -L 19999:localhost:19999 user@your-server-ip
```

Then open http://localhost:19999 in your browser.
Netdata does not require login by default.

Just skip the authentication and you are good to go !