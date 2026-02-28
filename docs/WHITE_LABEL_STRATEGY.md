# Yukta White-Label Strategy Document

**Brand Name:** Yukta (युक्त - Sanskrit for "Connected/United")
**Version:** 1.1
**Last Updated:** 2026-02-28
**Owner:** Utpal Raina

> **Note:** Brand changed from "UrERP" to "Yukta" for stronger identity.
> See `YUKTA_WHITE_LABEL_PLAN.md` for detailed implementation plan.

---

## Table of Contents
1. [Executive Summary](#1-executive-summary)
2. [Licensing & Legal](#2-licensing--legal)
3. [Branding Guidelines](#3-branding-guidelines)
4. [Technical Changes](#4-technical-changes)
5. [Feature Enhancements](#5-feature-enhancements)
6. [Go-to-Market Strategy](#6-go-to-market-strategy)
7. [Pricing Model](#7-pricing-model)
8. [Implementation Checklist](#8-implementation-checklist)
9. [Roadmap](#9-roadmap)

---

## 1. Executive Summary

### Vision
Transform Frappe/ERPNext HRMS into **Yukta** - a white-labeled, enterprise-grade Multi-Country HRMS solution targeting mid-to-large enterprises with operations across UAE, India, USA, Canada, Bhutan, and Korea.

**Tagline:** "Connected Workforce, United Success"

### Unique Value Proposition
- 20+ years Oracle HCM expertise baked into the product
- Native multi-country payroll compliance (WPS, PF/ESI, W2, etc.)
- UAE banking integrations (HSBC ISO 20022, ADCB CST, Ratibi)
- Enterprise-grade workflows and approvals
- Modern UI with powerful reporting

### Target Market
| Segment | Company Size | Geography |
|---------|--------------|-----------|
| Primary | 100-5000 employees | UAE, India |
| Secondary | 50-500 employees | USA, Canada, Korea |
| Tertiary | 500+ employees | Multi-country operations |

---

## 2. Licensing & Legal

### Base Software Licenses

| Component | License | Source Code Obligation |
|-----------|---------|------------------------|
| Frappe Framework | MIT | None - free to modify |
| ERPNext | GPLv3 | Must share if distributed |
| Frappe HRMS | GPLv3 | Must share if distributed |
| Custom HR Multi | Proprietary | Your IP |

### Compliance Strategy

#### Option A: SaaS Model (Recommended)
- **How:** Host UrERP on your servers, customers access via browser
- **Benefit:** No distribution = no source code sharing required
- **GPLv3 Compliant:** Yes

#### Option B: On-Premise with Open Core
- **How:** Core is open-source, premium features in separate proprietary apps
- **Benefit:** Enterprise features remain your IP
- **GPLv3 Compliant:** Yes (if core modifications are shared)

#### Option C: Dual Licensing
- **How:** Offer commercial license for enterprises wanting full ownership
- **Benefit:** Additional revenue stream
- **Requires:** Agreement with Frappe (complex)

### Legal Checklist
- [ ] Register "UrERP" trademark
- [ ] Draft Terms of Service
- [ ] Draft Privacy Policy
- [ ] Draft SaaS Agreement template
- [ ] Review GPLv3 compliance with legal counsel
- [ ] Create contribution agreement for contractors

---

## 3. Branding Guidelines

### Brand Identity

| Element | Current (ERPNext) | Yukta |
|---------|-------------------|-------|
| Name | ERPNext | Yukta (युक्त) |
| Tagline | Open Source ERP | Connected Workforce, United Success |
| Primary | #0089FF | #0F6B8C (Deep Teal Blue) |
| Secondary | #gray | #3D4F5F (Slate Gray) |
| Accent | - | #E8A838 (Saffron Gold) |
| Background | - | #F7F9FC (Off-White) |
| Text | - | #1A2332 (Charcoal) |
| Logo | ERPNext logo | TBD |
| Font | Inter | Inter |

### Brand Voice
- Professional yet approachable
- Enterprise-ready
- Global mindset, local expertise
- Solution-oriented

### Visual Assets Needed
- [ ] Logo (full, icon, monochrome versions)
- [ ] Color palette (primary, secondary, accent)
- [ ] Typography guidelines
- [ ] Icon set
- [ ] Illustration style
- [ ] Email signature template
- [ ] PowerPoint/Presentation template
- [ ] Business card design

---

## 4. Technical Changes

### 4.1 UI Branding Changes

#### Login Page
**File:** `frappe/www/login.html` or custom app override

```
Changes needed:
- [ ] Replace logo
- [ ] Update colors
- [ ] Custom background image/pattern
- [ ] Update footer text
- [ ] Remove "Powered by Frappe" or update
```

#### Navbar
**File:** `frappe/public/js/frappe/ui/toolbar/navbar.html`

```
Changes needed:
- [ ] Replace navbar logo
- [ ] Update brand colors
- [ ] Custom favicon
```

#### Desk (Workspace)
```
Changes needed:
- [ ] Custom workspace icons
- [ ] Module colors
- [ ] Welcome message
```

#### Email Templates
**Location:** Setup > Email > Email Template

```
Changes needed:
- [ ] Header with UrERP logo
- [ ] Footer with company info
- [ ] Color scheme updates
```

#### Print Formats
**Location:** Setup > Printing > Print Format

```
Changes needed:
- [ ] Letterhead design
- [ ] Footer with UrERP branding
- [ ] Custom fonts
```

### 4.2 System Configuration

#### Site Config Changes
**File:** `sites/[site]/site_config.json`

```json
{
  "app_name": "UrERP",
  "app_logo_url": "/assets/urerp/images/logo.png",
  "splash_image": "/assets/urerp/images/splash.png",
  "disable_website_theme": 1
}
```

#### Hooks Configuration
**File:** `custom_hr_multi/hooks.py`

```python
app_name = "UrERP"
app_title = "UrERP - Multi-Country HRMS"
app_publisher = "Utpal Raina"
app_description = "Enterprise HRMS Solution"
app_icon = "octicon octicon-globe"
app_color = "#YOUR_COLOR"
app_email = "support@urerp.com"
app_license = "Proprietary"

# Website branding
website_context = {
    "brand_html": "<img src='/assets/urerp/images/logo.png' style='height: 30px'>",
    "top_bar_items": [...],
    "footer_items": [...]
}
```

### 4.3 Files to Create/Modify

| File | Purpose | Status |
|------|---------|--------|
| `custom_hr_multi/public/images/logo.png` | Main logo | [ ] Pending |
| `custom_hr_multi/public/images/favicon.ico` | Browser favicon | [ ] Pending |
| `custom_hr_multi/public/css/urerp.css` | Custom styles | [ ] Pending |
| `custom_hr_multi/templates/includes/navbar.html` | Custom navbar | [ ] Pending |
| `custom_hr_multi/www/login.html` | Custom login page | [ ] Pending |
| `custom_hr_multi/www/index.html` | Landing page | [ ] Pending |

### 4.4 Remove ERPNext/Frappe Branding

```python
# In hooks.py - override templates
override_whitelisted_methods = {
    "frappe.www.login": "custom_hr_multi.www.login"
}

# Override Jinja templates
jinja_template_apps = ["custom_hr_multi"]
```

---

## 5. Feature Enhancements

### 5.1 Core Differentiators (Phase 1)

#### Multi-Country Payroll Engine
| Country | Features | Status |
|---------|----------|--------|
| UAE | WPS file generation, MOHRE compliance | [x] Built |
| UAE | HSBC ISO 20022 payment files | [x] Built |
| UAE | ADCB CST format, Ratibi cards | [x] Built |
| India | PF/ESI calculations, Form 16 | [ ] Planned |
| USA | W2, W4, state tax handling | [ ] Planned |
| Canada | T4, CPP, EI calculations | [ ] Planned |
| Korea | 4 insurances compliance | [ ] Planned |
| Bhutan | PF, GIS calculations | [ ] Planned |

#### Travel & Per Diem Management
| Feature | Status |
|---------|--------|
| Travel Request workflow | [x] Built |
| Per Diem rules by country/city | [x] Built |
| Approval matrix | [x] Built |
| Expense integration | [ ] Planned |

#### Shift & Overtime Management
| Feature | Status |
|---------|--------|
| Shift patterns | [x] Built |
| Overtime rules by country | [x] Built |
| Auto-calculation | [x] Built |
| Biometric integration | [ ] Planned |

### 5.2 Planned Enhancements (Phase 2)

#### Mobile App
- Employee self-service
- Leave requests
- Attendance (geo-fenced)
- Payslip viewing
- Push notifications

#### AI/ML Features
- Attrition prediction
- Skill gap analysis
- Interview scheduling optimization
- Resume parsing

#### Integrations
| System | Purpose | Priority |
|--------|---------|----------|
| Microsoft 365 | Calendar, Email | High |
| Google Workspace | Calendar, Email | High |
| Slack | Notifications | Medium |
| LinkedIn | Recruiting | Medium |
| Zoom/Teams | Interview scheduling | Medium |
| Power BI | Advanced analytics | High |
| QuickBooks | Accounting sync | Low |

### 5.3 Reporting & Analytics

#### Standard Reports
- [ ] Headcount analysis
- [ ] Turnover rates
- [ ] Leave balance summary
- [ ] Overtime analysis
- [ ] Payroll cost by department
- [ ] Compliance status dashboard

#### Executive Dashboards
- [ ] HR KPIs dashboard
- [ ] Cost center analysis
- [ ] Workforce planning
- [ ] Diversity metrics

---

## 6. Go-to-Market Strategy

### 6.1 Market Positioning

```
                    High Price
                        │
     Oracle HCM ●       │       ● SAP SuccessFactors
                        │
                        │
    UrERP ●─────────────┼─────────● Workday
    (Target Position)   │
                        │
    Zoho People ●       │       ● BambooHR
                        │
                    Low Price

    Simple ◄────────────┴────────────► Complex
```

### 6.2 Target Personas

#### Persona 1: HR Director (Decision Maker)
- **Pain:** Managing multi-country compliance manually
- **Need:** Unified system with local compliance
- **Messaging:** "One system, all countries, full compliance"

#### Persona 2: CFO (Budget Holder)
- **Pain:** High cost of Oracle/SAP
- **Need:** Enterprise features at reasonable cost
- **Messaging:** "Enterprise HRMS at 1/10th the cost"

#### Persona 3: IT Manager (Influencer)
- **Pain:** Integration complexity
- **Need:** Open APIs, easy customization
- **Messaging:** "Open source flexibility, enterprise support"

### 6.3 Sales Channels

| Channel | Approach | Timeline |
|---------|----------|----------|
| Direct Sales | Enterprise accounts | Immediate |
| Website | Inbound leads | Q1 |
| Partners | Reseller network | Q2 |
| Marketplace | AWS/Azure listings | Q3 |
| Referrals | Customer referral program | Q2 |

### 6.4 Marketing Activities

#### Website (urerp.com)
- [ ] Landing page with value props
- [ ] Feature pages by module
- [ ] Pricing page
- [ ] Demo request form
- [ ] Customer testimonials
- [ ] Blog/Resources section
- [ ] Documentation portal

#### Content Marketing
- [ ] "Multi-Country Payroll Guide" eBook
- [ ] UAE WPS compliance blog series
- [ ] Comparison guides (vs Oracle, SAP, Workday)
- [ ] Case studies
- [ ] Webinars

#### Paid Marketing
- [ ] Google Ads (HRMS keywords)
- [ ] LinkedIn Ads (HR decision makers)
- [ ] Retargeting campaigns

---

## 7. Pricing Model

### 7.1 SaaS Pricing Tiers

| Tier | Price | Users | Features |
|------|-------|-------|----------|
| **Starter** | $5/user/month | Up to 50 | Core HR, Leave, Attendance |
| **Professional** | $12/user/month | Up to 500 | + Payroll, Recruitment, Performance |
| **Enterprise** | Custom | Unlimited | + Multi-country, API, SSO, SLA |

### 7.2 Add-ons

| Add-on | Price | Description |
|--------|-------|-------------|
| Multi-Country Payroll | $3/user/month | Per additional country |
| Mobile App | $2/user/month | iOS + Android apps |
| API Access | $500/month | Full REST API access |
| Custom Reports | $200/report | One-time |
| Data Migration | From $2,000 | One-time |

### 7.3 Services Pricing

| Service | Price | Notes |
|---------|-------|-------|
| Implementation | $5,000 - $50,000 | Based on complexity |
| Training | $500/day | On-site or remote |
| Custom Development | $150/hour | Bespoke features |
| Annual Support | 20% of license | Includes updates |

### 7.4 Competitive Comparison

| Feature | UrERP | Oracle HCM | Workday | BambooHR |
|---------|-------|------------|---------|----------|
| Price/user/month | $12 | $30+ | $25+ | $8 |
| Multi-country payroll | Yes | Yes | Yes | No |
| UAE WPS | Yes | Limited | No | No |
| Open Source | Yes | No | No | No |
| On-premise option | Yes | No | No | No |

---

## 8. Implementation Checklist

### Phase 1: Foundation (Week 1-4)
- [ ] Register UrERP trademark
- [ ] Set up company entity (if needed)
- [ ] Design logo and brand guidelines
- [ ] Set up domain (urerp.com)
- [ ] Set up cloud infrastructure (AWS/Azure)
- [ ] Create staging environment

### Phase 2: Technical (Week 5-8)
- [ ] Implement login page branding
- [ ] Implement navbar branding
- [ ] Create custom favicon
- [ ] Update email templates
- [ ] Create print format templates
- [ ] Remove ERPNext/Frappe references
- [ ] Set up CI/CD pipeline

### Phase 3: Product (Week 9-12)
- [ ] Document existing custom_hr_multi features
- [ ] Create user documentation
- [ ] Record demo videos
- [ ] Set up demo instance
- [ ] Create sample data

### Phase 4: Go-to-Market (Week 13-16)
- [ ] Launch website
- [ ] Set up CRM for leads
- [ ] Create sales deck
- [ ] Create pricing calculator
- [ ] Launch initial marketing campaigns
- [ ] Reach out to first prospects

### Phase 5: Operations (Ongoing)
- [ ] Set up support ticketing
- [ ] Create SLA documentation
- [ ] Establish backup procedures
- [ ] Monitor system performance
- [ ] Collect customer feedback

---

## 9. Roadmap

### Q1 2026 (Current)
- [x] PostgreSQL migration
- [x] Docker deployment setup
- [ ] Complete white-labeling
- [ ] Launch website
- [ ] First paying customer

### Q2 2026
- [ ] India payroll module
- [ ] Mobile app MVP
- [ ] 10 customers milestone
- [ ] Partner program launch

### Q3 2026
- [ ] USA payroll module
- [ ] Advanced analytics
- [ ] 50 customers milestone
- [ ] Series A preparation (if applicable)

### Q4 2026
- [ ] Canada/Korea payroll
- [ ] AI features MVP
- [ ] 100 customers milestone

---

## Appendix

### A. Technical Stack

| Layer | Technology |
|-------|------------|
| Backend | Python 3.11, Frappe Framework |
| Database | PostgreSQL 16 |
| Cache | Redis 7 |
| Frontend | Frappe UI (Jinja + JS) |
| Mobile | Flutter (planned) |
| Hosting | AWS / Azure |
| CI/CD | GitHub Actions |
| Monitoring | Prometheus + Grafana |

### B. Team Requirements

| Role | Count | Status |
|------|-------|--------|
| Product Manager | 1 | Utpal (Owner) |
| Full-stack Developer | 2 | Needed |
| Frontend Developer | 1 | Needed |
| DevOps Engineer | 1 | Needed |
| QA Engineer | 1 | Needed |
| Sales | 1 | Needed |
| Customer Success | 1 | Later |

### C. Key Contacts

| Role | Name | Contact |
|------|------|---------|
| Owner | Utpal Raina | - |
| Technical | - | - |
| Legal | - | - |
| Design | - | - |

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-02-28 | Claude/Utpal | Initial document |

---

*This is a living document. Update regularly as the project progresses.*
