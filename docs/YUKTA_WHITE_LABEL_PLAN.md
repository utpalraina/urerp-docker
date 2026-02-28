# Yukta - White-Label Implementation Plan

**Brand Name:** Yukta (युक्त)
**Meaning:** Connected, United, Appropriate (Sanskrit)
**Tagline Options:**
- "Connected Workforce, United Success"
- "Your People, Perfectly Connected"
- "Enterprise HR, Elegantly United"

---

## Phase 1: Brand Identity

### 1.1 Name & Domain
| Item | Decision | Status |
|------|----------|--------|
| Brand Name | Yukta | Decided |
| Domain | yukta.io / yuktahr.com / getyukta.com | [ ] To decide |
| Trademark | File in UAE/India | [ ] Pending |

### 1.2 Color Palette (FINAL)

**"Modern & Clean" — Blue + Teal + Slate with Vedic Touch**

| Role | Color | Hex | Purpose |
|------|-------|-----|---------|
| **Primary** | Deep Teal Blue | `#0F6B8C` | Trust + innovation, unique |
| **Secondary** | Slate Gray | `#3D4F5F` | Professional, readable |
| **Accent** | Saffron Gold | `#E8A838` | Vedic touch, CTAs |
| **Background** | Off-White | `#F7F9FC` | Clean, modern |
| **Text** | Charcoal | `#1A2332` | Maximum readability |

```css
:root {
  --yukta-primary: #0F6B8C;
  --yukta-secondary: #3D4F5F;
  --yukta-accent: #E8A838;
  --yukta-background: #F7F9FC;
  --yukta-text: #1A2332;
}
```

**Visual Preview:**
```
┌────────────────────────────────────────┐
│  ████ Primary    #0F6B8C (Teal Blue)  │
│  ████ Secondary  #3D4F5F (Slate)      │
│  ████ Accent     #E8A838 (Saffron)    │
│  ████ Background #F7F9FC (Off-White)  │
│  ████ Text       #1A2332 (Charcoal)   │
└────────────────────────────────────────┘
```

### 1.3 Typography (FINAL)

| Use | Font | Weight | Purpose |
|-----|------|--------|---------|
| **Headings** | Outfit | 700-800 | Logo text, titles, headers |
| **Body** | DM Sans | 400-600 | Body text, UI labels, forms |
| **Accent** | Sora | 500-700 | Badges, labels, technical text |

```css
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=DM+Sans:wght@400;500;600;700&family=Sora:wght@300;400;500;600;700&display=swap');

:root {
  --font-heading: 'Outfit', system-ui, sans-serif;
  --font-body: 'DM Sans', system-ui, sans-serif;
  --font-accent: 'Sora', system-ui, sans-serif;
}
```

### 1.4 Logo (FINAL - Concept 05: Hybrid)

**Design:** Clean "Y" stroke + subtle sacred circle. Saffron gold stem for stability.

| Version | File | Use Case |
|---------|------|----------|
| Full Logo | `yukta-logo.svg` | Navbar, headers (dark text) |
| White Logo | `yukta-logo-white.svg` | Dark backgrounds |
| Icon Only | `yukta-icon.svg` | Favicon, app icon |
| With Tagline | `yukta-logo-full.svg` | Login page, marketing |

**Logo Icon Symbolism:**
- **Y Shape:** Convergence - all paths unite
- **Sacred Circle:** Vedic roots, cosmic unity
- **Saffron Stem:** Stability, grounding

```
      ╱ ╲
     ╱   ╲      ← Teal Blue (#0F6B8C)
    ╱     ╲
     ╲   ╱
      │         ← Saffron Gold (#E8A838)
      │
```

---

## Phase 2: Technical Implementation

### 2.1 File Structure to Create

```
custom_hr_multi/
├── public/
│   ├── images/
│   │   ├── yukta-logo.svg           # Main logo
│   │   ├── yukta-logo-white.svg     # White version
│   │   ├── yukta-icon.svg           # Icon only
│   │   ├── yukta-favicon.ico        # Favicon
│   │   ├── yukta-splash.png         # Mobile splash
│   │   └── login-bg.jpg             # Login background
│   ├── css/
│   │   └── yukta-theme.css          # Custom styles
│   └── js/
│       └── yukta-branding.js        # Branding overrides
├── templates/
│   ├── includes/
│   │   ├── navbar/
│   │   │   └── navbar_logo.html     # Custom navbar
│   │   └── footer.html              # Custom footer
│   └── www/
│       └── login.html               # Custom login page
└── hooks.py                          # App configuration
```

### 2.2 Login Page Customization

**File:** `custom_hr_multi/www/login.html`

```html
{% extends "frappe/www/login.html" %}

{% block title %}Yukta - Login{% endblock %}

{% block page_content %}
<div class="yukta-login-container">
  <div class="yukta-login-left">
    <!-- Background image or illustration -->
  </div>
  <div class="yukta-login-right">
    <img src="/assets/custom_hr_multi/images/yukta-logo.svg" class="yukta-logo">
    <h2>Welcome to Yukta</h2>
    <p>Connected Workforce, United Success</p>
    {{ super() }}
  </div>
</div>
{% endblock %}
```

### 2.3 CSS Theme

**File:** `custom_hr_multi/public/css/yukta-theme.css`

```css
:root {
  /* Yukta Brand Colors */
  --yukta-primary: #0F6B8C;      /* Deep Teal Blue */
  --yukta-secondary: #3D4F5F;    /* Slate Gray */
  --yukta-accent: #E8A838;       /* Saffron Gold */
  --yukta-background: #F7F9FC;   /* Off-White */
  --yukta-text: #1A2332;         /* Charcoal */

  /* Override Frappe variables */
  --primary: var(--yukta-primary);
  --primary-dark: #0A4D66;       /* Darker teal for hover */
  --text-color: var(--yukta-text);
  --bg-color: var(--yukta-background);
}

/* Login Page */
.yukta-login-container {
  display: flex;
  min-height: 100vh;
  background: var(--yukta-background);
}

.yukta-login-left {
  flex: 1;
  background: linear-gradient(135deg, var(--yukta-primary), #0A4D66);
  display: flex;
  align-items: center;
  justify-content: center;
}

.yukta-login-right {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 3rem;
  max-width: 480px;
}

.yukta-logo {
  height: 48px;
  margin-bottom: 2rem;
}

.yukta-tagline {
  color: var(--yukta-secondary);
  font-size: 1rem;
  margin-bottom: 2rem;
}

/* Navbar */
.navbar {
  background: var(--yukta-primary) !important;
}

.navbar-brand img {
  height: 30px;
}

/* Buttons */
.btn-primary {
  background: var(--yukta-primary);
  border-color: var(--yukta-primary);
}

.btn-primary:hover {
  background: #0A4D66;
  border-color: #0A4D66;
}

/* Accent buttons (CTAs) */
.btn-accent, .btn-warning {
  background: var(--yukta-accent);
  border-color: var(--yukta-accent);
  color: var(--yukta-text);
}

/* Links */
a {
  color: var(--yukta-primary);
}

a:hover {
  color: #0A4D66;
}
```

### 2.4 Hooks Configuration

**File:** `custom_hr_multi/hooks.py`

```python
app_name = "custom_hr_multi"
app_title = "Yukta"
app_publisher = "Yukta Technologies"
app_description = "Multi-Country HRMS - Connected Workforce, United Success"
app_icon = "octicon octicon-globe"
app_color = "#2563EB"
app_email = "support@yukta.io"
app_license = "Proprietary"

# Branding
app_logo_url = "/assets/custom_hr_multi/images/yukta-logo.svg"
splash_image = "/assets/custom_hr_multi/images/yukta-splash.png"

# Website
website_context = {
    "brand_html": '<img src="/assets/custom_hr_multi/images/yukta-logo.svg" style="height: 30px">',
    "favicon": "/assets/custom_hr_multi/images/yukta-favicon.ico",
    "splash_image": "/assets/custom_hr_multi/images/yukta-splash.png"
}

# Include CSS/JS
app_include_css = [
    "/assets/custom_hr_multi/css/yukta-theme.css"
]

app_include_js = [
    "/assets/custom_hr_multi/js/yukta-branding.js"
]

# Override templates
override_doctype_dashboards = {
    # Custom dashboard overrides
}

# Remove Frappe/ERPNext branding
boot_session = "custom_hr_multi.boot.boot_session"
```

### 2.5 Boot Session (Remove Default Branding)

**File:** `custom_hr_multi/boot.py`

```python
import frappe

def boot_session(bootinfo):
    """Customize boot session with Yukta branding"""
    bootinfo.app_name = "Yukta"
    bootinfo.app_logo_url = "/assets/custom_hr_multi/images/yukta-logo.svg"
    bootinfo.favicon = "/assets/custom_hr_multi/images/yukta-favicon.ico"

    # Override default strings
    bootinfo.brand_html = '<img src="/assets/custom_hr_multi/images/yukta-logo.svg" style="height: 30px">'

    # Remove ERPNext references
    if 'erpnext' in bootinfo.get('app_name', '').lower():
        bootinfo.app_name = "Yukta"
```

---

## Phase 3: Email & Print Templates

### 3.1 Email Header Template

**Location:** Setup > Email > Email Template

```html
<div style="max-width: 600px; margin: 0 auto; font-family: Inter, sans-serif;">
  <div style="background: #2563EB; padding: 20px; text-align: center;">
    <img src="https://yukta.io/logo-white.svg" height="40" alt="Yukta">
  </div>
  <div style="padding: 30px; background: #ffffff;">
    {{ message }}
  </div>
  <div style="background: #f8fafc; padding: 20px; text-align: center; font-size: 12px; color: #64748b;">
    <p>Yukta - Connected Workforce, United Success</p>
    <p>support@yukta.io | www.yukta.io</p>
  </div>
</div>
```

### 3.2 Print Format Header

**Location:** Setup > Printing > Print Format

```html
<div class="print-header">
  <img src="/assets/custom_hr_multi/images/yukta-logo.svg" style="height: 50px;">
  <div class="company-info">
    {{ company_name }}
    {{ company_address }}
  </div>
</div>
```

---

## Phase 4: Workspace Customization

### 4.1 Custom Workspaces

| Workspace | Icon | Color | Modules |
|-----------|------|-------|---------|
| HR Home | users | #2563EB | Dashboard, Quick Actions |
| Employees | user | #059669 | Employee, Onboarding |
| Payroll | dollar-sign | #F59E0B | Salary, Payments |
| Leave | calendar | #8B5CF6 | Leave, Holidays |
| Attendance | clock | #EC4899 | Attendance, Shifts |
| Recruitment | briefcase | #06B6D4 | Jobs, Candidates |

### 4.2 Dashboard Widgets

```
┌─────────────────────────────────────────────────────────┐
│  Welcome to Yukta                           [User ▼]   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │
│  │   👥 245    │ │   📅 12     │ │   💰 5.2M   │       │
│  │  Employees  │ │ Leave Today │ │ Payroll     │       │
│  └─────────────┘ └─────────────┘ └─────────────┘       │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │           Headcount Trend (Chart)               │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Quick Actions:                                         │
│  [+ New Employee] [Request Leave] [Run Payroll]        │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## Phase 5: Implementation Checklist

### Week 1: Brand Foundation
- [ ] Finalize color palette
- [ ] Create logo (or use placeholder)
- [ ] Register domain
- [ ] Set up brand guidelines document

### Week 2: Technical Setup
- [ ] Create file structure in custom_hr_multi
- [ ] Implement yukta-theme.css
- [ ] Update hooks.py
- [ ] Create boot.py

### Week 3: UI Implementation
- [ ] Custom login page
- [ ] Navbar branding
- [ ] Favicon
- [ ] Footer updates

### Week 4: Templates & Polish
- [ ] Email templates
- [ ] Print formats
- [ ] Workspace customization
- [ ] Testing & QA

---

## Decisions Needed

1. **Domain:** yukta.io / yuktahr.com / getyukta.com ?
2. **Color Palette:** Blue / Green / Purple ?
3. **Logo:** Design in-house or hire designer ?
4. **Tagline:** Which one resonates best ?

---

## Next Steps

1. Make brand decisions (domain, colors)
2. Create/obtain logo assets
3. Start technical implementation
4. Test in Docker environment

---

*Document created: 2026-02-28*
*Brand: Yukta (युक्त)*
