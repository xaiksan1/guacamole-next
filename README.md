# Guacamole-Next

A modern, customized Hyprland Wayland desktop environment configuration for Debian-based systems. This repository provides automated installation scripts and configuration files for a complete, minimal, and aesthetically pleasing desktop environment.

![Hyprland Desktop Environment](https://i.imgur.com/YourScreenshot.png)

## 🌟 Features

- **Hyprland** - A dynamic tiling Wayland compositor
- **Waybar** - Highly customizable status bar
- **Dunst** - Lightweight notification daemon
- **Wofi** - Application launcher with modern UI
- **Alacritty** - Fast, GPU-accelerated terminal emulator
- **Grim & Slurp** - Screenshot utilities for Wayland
- **Media Integration** - Media player controls in Waybar

## 📋 System Requirements

- Debian or Ubuntu-based Linux distribution
- Wayland-compatible GPU
- Git

## 🚀 Installation

### One-Command Installation

For a complete setup, run:

```bash
git clone https://github.com/username/guacamole-next.git
cd guacamole-next
chmod +x install-hyprland-deps.sh
./install-hyprland-deps.sh
```

### Manual Installation

If you prefer to install components individually:

1. Install dependencies:
   ```bash
   sudo apt update
   sudo apt install -y git meson ninja-build build-essential \
     libwayland-dev wayland-protocols libwlroots-dev libinput-dev \
     libxkbcommon-dev libdisplay-info-dev libseat-dev \
     xwayland scdoc dunst wl-clipboard
   ```

2. Build Hyprland and other components from source as needed.

3. Copy configuration files:
   ```bash
   mkdir -p ~/.config/{hypr,waybar,dunst,wofi}
   cp -r config/* ~/.config/
   ```

## ⚙️ Configuration Files

- **Hyprland**: `~/.config/hypr/hyprland.conf`
- **Waybar**: `~/.config/waybar/{config.json,style.css,mediaplayer.py}`
- **Dunst**: `~/.config/dunst/dunstrc`
- **Wofi**: `~/.config/wofi/style.css`

## 🎮 Default Keybindings

| Key Combination | Action |
|-----------------|--------|
| `Super + Return` | Open terminal (Alacritty) |
| `Super + Q` | Close active window |
| `Super + Shift + Q` | Exit Hyprland |
| `Super + Space` | Toggle floating mode |
| `Super + D` | Open application launcher (Wofi) |
| `Super + 1-0` | Switch to workspace 1-10 |
| `Super + Shift + 1-0` | Move window to workspace 1-10 |
| `Super + Print` | Screenshot selected area |
| `Super + Left/Right/Up/Down` | Move focus in direction |
| `Super + P` | Toggle pseudo mode |
| `Super + S` | Toggle split direction |

## 🎨 Customization

### Changing Theme Colors

The default theme uses a blue accent color scheme. To modify:

1. Edit Waybar's style: `~/.config/waybar/style.css`
2. Edit Hyprland's colors: `~/.config/hypr/hyprland.conf` 
3. Edit Wofi's style: `~/.config/wofi/style.css`

### Monitor Configuration

For multi-monitor setups, edit the monitor section in `~/.config/hypr/hyprland.conf`:

```
monitor=DP-1,2560x1440@144,0x0,1
monitor=HDMI-A-1,1920x1080@60,2560x0,1
```

## 🔧 Troubleshooting

### Common Issues

- **Hyprland not appearing in login screen**: Ensure the `.desktop` file is properly installed in `/usr/share/wayland-sessions/`
- **Black screen after login**: Check for GPU driver compatibility with Wayland
- **Missing icons in Waybar**: Install a compatible icon font like `Font Awesome`
- **Media controls not working**: Ensure `playerctl` is installed and the Python script has execution permissions

### Logs

Check logs for debugging:
```bash
cat ~/.local/share/hyprland/hyprland.log
```

## 📚 Additional Resources

- [Hyprland Documentation](https://wiki.hyprland.org/)
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Wofi Documentation](https://hg.sr.ht/~scoopta/wofi)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgements

- [Hyprland](https://hyprland.org/) developers
- [Waybar](https://github.com/Alexays/Waybar) team
- The Wayland community
- All other open-source projects included

# Guacamole Next: Advanced Remote Access Platform

![Project Status](https://img.shields.io/badge/status-in%20development-blue)
![License](https://img.shields.io/badge/license-Apache%202.0-green)
![Version](https://img.shields.io/badge/version-0.1.0-orange)

## 📖 Overview

Guacamole Next is an ambitious enhancement project that transforms Apache Guacamole into a modern, AI-integrated remote access solution. By combining the power of Apache Guacamole with Next.js, TypeScript, and AI capabilities, this project creates a more robust, user-friendly, and secure remote access platform.

### Key Features

- **Enhanced Compatibility:** Works seamlessly across all major browsers
- **Modern UI:** Built with Next.js and TailwindCSS for a responsive, intuitive interface
- **AI Integration:** Intelligent assistance and automation for remote access tasks
- **Security First:** Zero Trust Architecture with enhanced security measures
- **Cross-Platform:** Web and mobile support with consistent experience
- **Monitoring:** Real-time monitoring and logging with 1panel.io integration
- **Chain Proxies:** Advanced networking with bare-metal hypervisor for secure communications

---

## 🏛️ Architecture

### System Architecture

```
┌───────────────────────────────────────────────────────────────┐
│                        Client Layer                           │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────────┐   │
│  │   Web App    │   │ Mobile App   │   │ Desktop Client   │   │
│  │  (Next.js)   │   │ (Responsive) │   │   (Electron)     │   │
│  └──────┬───────┘   └──────┬───────┘   └────────┬─────────┘   │
└─────────┼────────────────┬─┼────────────────────┼─────────────┘
          │                │ │                    │
          ▼                │ │                    │
┌───────────────────────┐ │ │ ┌──────────────────▼───────────────┐
│   Security Layer      │ │ │ │        API Gateway               │
│  ┌─────────────────┐  │ │ └─┼──────────┬────────────┬──────────┤
│  │      WAF        │  │ │   │ Auth API │ Core API   │ AI API   │
│  └────────┬────────┘  │ │   └──────────┴────────────┴──────────┘
│           │           │ │                    │
│  ┌────────▼────────┐  │ │                    │
│  │  Chain Proxies  │◄─┘ │                    │
│  └────────┬────────┘    │                    │
└───────────┼─────────────┘                    │
            │                                   │
┌───────────▼───────────────────────────────────▼───────────────┐
│                     Backend Services                           │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────────┐   │
│  │  Guacamole   │   │ AI Services  │   │   Monitoring     │   │
│  │  (Tomcat 10) │   │(agent-chat-ui)│  │   (1panel.io)    │   │
│  └──────┬───────┘   └──────┬───────┘   └────────┬─────────┘   │
└─────────┼────────────────┬─┼────────────────────┼─────────────┘
          │                │ │                    │
          ▼                ▼ ▼                    ▼
┌───────────────────────────────────────────────────────────────┐
│                     Infrastructure Layer                       │
│  ┌──────────────┐   ┌──────────────┐   ┌──────────────────┐   │
│  │   Docker     │   │  Databases   │   │  Cache Layer     │   │
│  │  Containers  │   │  (SQL/NoSQL) │   │    (Redis)       │   │
│  └──────────────┘   └──────────────┘   └──────────────────┘   │
└───────────────────────────────────────────────────────────────┘
```

### Code Architecture

Our project follows a monorepo structure for better organization:

```
/
├── apps/
│   ├── web/           (Next.js frontend)
│   └── api/           (Backend services)
├── packages/
│   ├── shared/        (Shared utilities)
│   ├── ui/            (Component library)
│   └── ai-service/    (AI integration)
└── infrastructure/    (DevOps configs)
```

This architecture allows for:
- **Separation of concerns:** Each component has a specific responsibility
- **Code reusability:** Shared packages reduce duplication
- **Independent deployment:** Services can be deployed separately or together
- **Easier testing:** Components can be tested in isolation

---

## 🧠 Development Philosophy

We follow these core principles:

### 1. DevSecOps Integration

Security is not an afterthought but integrated throughout the development lifecycle. Every feature, enhancement, and fix undergoes security validation.

### 2. Shift-Left Testing

Testing begins at the earliest stages of development. Developers write tests concurrently with code, ensuring quality from the start.

### 3. Continuous Improvement

The codebase is constantly evolving. We embrace refactoring, performance optimization, and architecture enhancement.

### 4. Educational Approach

Code is written to be understood, not just executed. Documentation, comments, and structure prioritize knowledge transfer.

### 5. Cross-Browser Compatibility

Logical properties and responsive design ensure consistent functionality across all browsers and devices.

---

## 📋 Best Practices

### Code Quality

| Practice | Description | Example |
|----------|-------------|---------|
| **TypeScript Everywhere** | Use TypeScript for type safety and better developer experience | `function connect(params: ConnectionParams): Promise<Connection>` |
| **ESLint Configuration** | Apply strict linting rules to maintain code quality | `npm run lint` checks code quality |
| **Component Architecture** | Build isolated, reusable components | `<GuacamoleViewer protocol="vnc" hostname="server1" />` |
| **Testing** | Implement comprehensive testing (unit, integration, E2E) | `test('connection establishes', async () => {...})` |

### Security Practices

- **Input Validation:** Validate all inputs at every layer
- **OWASP Compliance:** Adhere to OWASP Top 10 security guidelines
- **Principle of Least Privilege:** Services only have access to what they need
- **Zero Trust:** Trust nothing, verify everything
- **Regular Scanning:** Automated vulnerability and dependency checks

### Performance Optimization

- Code splitting and lazy loading
- Server-side rendering for critical paths
- Edge caching where appropriate
- Image optimization and WebP format
- Web Vitals monitoring and optimization

---

## 🚀 Setup Instructions

### Prerequisites

- Node.js (v18 or newer)
- Docker and Docker Compose
- Git
- (Optional) Java JDK 11+ for Tomcat-related development

### Development Environment Setup

1. **Clone the repository**

```bash
git clone https://github.com/your-username/guacamole-next.git
cd guacamole-next
```

2. **Install dependencies**

```bash
npm install
```

3. **Start development environment**

```bash
# Start Docker services
docker-compose up -d

# Start development server
npm run dev
```

4. **Access the application**

The application will be available at:
- Web UI: http://localhost:3000
- API: http://localhost:3001
- Guacamole (direct): http://localhost:8080/guacamole

### Environment Configuration

Create a `.env.local` file in the root directory:

```
# Core services
NEXT_PUBLIC_API_URL=http://localhost:3001
GUACAMOLE_URL=http://localhost:8080/guacamole

# Authentication
AUTH_SECRET=your-secret-key
AUTH_TRUST_HOST=true

# AI services
AI_API_KEY=your-ai-service-key
```

---

## 🤝 Contributing Guidelines

### Workflow

1. **Fork and Clone**
   - Fork the repository
   - Clone your fork locally

2. **Branch**
   - Create a feature branch: `git checkout -b feature/your-feature-name`
   - For bugs: `git checkout -b fix/bug-description`

3. **Develop**
   - Follow coding standards
   - Write tests for your code
   - Keep commits small and focused

4. **Test**
   - Run tests: `npm test`
   - Ensure all linting passes: `npm run lint`

5. **Submit**
   - Push to your fork
   - Create a Pull Request with detailed description

### Code Review Criteria

- Does the code follow project standards?
- Is it properly tested?
- Does it maintain backward compatibility?
- Is there adequate documentation?
- Does it address security concerns?

---

## 📚 Educational Resources

### Learning Paths

**For Frontend Developers:**
- [Next.js Documentation](https://nextjs.org/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [TailwindCSS Documentation](https://tailwindcss.com/docs)
- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)

**For Backend Developers:**
- [Apache Guacamole Documentation](https://guacamole.apache.org/doc/gug/)
- [Tomcat 10 Documentation](https://tomcat.apache.org/tomcat-10.0-doc/index.html)
- [Java Security Best Practices](https://owasp.org/www-project-proactive-controls/)
- [Docker Documentation](https://docs.docker.com/)

**For DevOps:**
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)

### Key Concepts Explained

| Concept | Description | Why It Matters |
|---------|-------------|---------------|
| **Remote Desktop Protocol (RDP)** | Network protocol for remote GUI access | Core protocol for Windows remote access |
| **VNC (Virtual Network Computing)** | Graphical desktop-sharing system | Platform-independent remote access |
| **SSH (Secure Shell)** | Cryptographic network protocol | Secure terminal access to remote systems |
| **WebSockets** | Persistent connection protocol | Enables real-time communication |
| **Zero Trust Architecture** | Security model that trusts nothing by default | Essential for secure remote access |

---

## 📝 Implementation Guide

### Phase 1: Foundation and Security

#### Project Initialization
- Configure Next.js with TypeScript
- Setup monorepo structure
- Implement ESLint and Prettier
- Create initial documentation

#### Security Foundation
- Implement authentication framework
- Setup WAF configuration
- Configure network security
- Implement secret management
- Setup audit logging

#### Development Environment
- Create Docker Compose configuration
- Setup Tomcat service
- Configure database services
- Implement development scripts
- Configure local HTTPS

### Phase 2: Core Architecture

#### Backend Foundation
- Setup Tomcat 10 with security configurations
- Implement connection pooling
- Configure session management
- Setup caching layer
- Implement rate limiting

#### Chain Proxy Architecture
- Design proxy topology
- Implement bare-metal hypervisor integration
- Configure network isolation
- Setup traffic routing
- Create failover mechanisms

#### Authentication & Authorization
- Implement OAuth2/OIDC
- Create role-based access
- Configure SSO integration
- Implement MFA
- Setup session management

### Phase 3: Integration Layer

#### Guacamole Core Integration
- Enhance authentication mechanisms
- Improve connection management
- Optimize protocol handlers
- Develop custom extensions
- Perform performance optimizations

#### AI Service Integration
- Fork and customize agent-chat-ui
- Create AI service endpoints
- Setup WebSocket communication
- Implement caching for AI responses
- Add fallback mechanisms

### Phase 4: Frontend Architecture

#### UI Framework
- Develop design system
- Create component library
- Implement layout system
- Setup theme management
- Add accessibility features

#### Cross-Browser Compatibility
- Implement CSS logical properties
- Create browser-specific optimizations
- Develop polyfill strategy
- Implement feature detection
- Setup cross-browser testing

#### Performance Optimization
- Implement code splitting
- Configure lazy loading
- Setup caching strategies
- Optimize assets
- Implement PWA capabilities

### Phase 5: Monitoring and Management

#### Observability Stack
- Setup 1panel.io integration
- Implement distributed tracing
- Configure metrics collection
- Setup log aggregation
- Implement health checks

#### DevSecOps Pipeline
- Create security scanning
- Setup performance monitoring
- Implement dependency scanning
- Configure container scanning
- Setup IaC validation

### Phase 6: Testing and Quality Assurance

#### Testing Strategy
- Implement unit testing
- Setup integration testing
- Configure E2E testing
- Perform performance testing
- Conduct security testing
- Ensure accessibility testing

#### Deployment Strategy
- Configure Blue-Green deployment
- Setup Canary releases
- Implement automated rollbacks
- Create database migration strategy
- Develop backup procedures

### Phase 7: Documentation and Maintenance

#### Documentation
- Create architecture documentation
- Generate API documentation
- Develop security guidelines
- Write deployment guides
- Produce troubleshooting guides

#### Maintenance and Updates
- Establish update strategy
- Configure security patching
- Setup performance monitoring
- Implement backup verification
- Create disaster recovery plans

---

## 🔄 Versioning and Releases

We follow Semantic Versioning (SemVer):
- **Major version (X.0.0)**: Incompatible API changes
- **Minor version (0.X.0)**: Backwards-compatible functionality
- **Patch version (0.0.X)**: Backwards-compatible bug fixes

Release cycle:
- **Alpha releases**: Early testing, expect bugs
- **Beta releases**: Feature complete, stabilization phase
- **Release candidates**: Final testing before production
- **Production releases**: Stable, production-ready code

---

## 📜 License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.

---

## 🙏 Acknowledgments

- Apache Guacamole project for the amazing foundation
- The Next.js team for their exceptional framework
- All contributors and community members

---

*"Code is like humor. When you have to explain it, it's bad." – Cory House*

This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
