# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A traditional JSP/Servlet chatroom built with raw JSP scriptlets (no Spring, no MVC framework). Managed as an IntelliJ IDEA project targeting Tomcat. There is no build tool (no Maven/Gradle/Ant) and no test suite.

## Development Workflow

**There are no CLI build or test commands.** All compilation and deployment is done via IntelliJ IDEA or by manually copying files to Tomcat.

**To deploy changes:**
1. Copy modified `.jsp` files directly to Tomcat's `webapps/chatroom/` directory — JSP changes take effect immediately on next request without restart.
2. If `src/bean/Dbcon.java` or `src/filter/CharacterEncodingFilter.java` change, recompile and copy the resulting `.class` files to `WebRoot/WEB-INF/classes/` (mirrored in `classes/artifacts/chatroom_war_exploded/WEB-INF/classes/`), then restart Tomcat.
3. The JDBC driver in use is `mysql-connector-j-9.5.0.jar` (Jakarta-compatible). The older `mysql-connector-java-5.0.8-bin.jar` in the artifact lib folder is unused.

**Database:**
- MySQL at `localhost:3306`, database `chatroomdb`, user `root`
- **Critical:** The actual deployed `user` table has only three columns: `id`, `name`, `password`. The `database/chatroomdb.sql` schema file is out of sync — it shows `username` and `sex` columns that do not exist in the real DB.
- Always use `WHERE name = ? AND password = ?` in `checkuser.jsp`. Never reference `username` or `sex` columns.

## Architecture

### Shared State (application scope)

All runtime chatroom state lives in `ServletContext` (the `application` implicit object). There is no database persistence for messages.

| Key | Type | Meaning |
|-----|------|---------|
| `sentence` | String (int) | Fixed capacity = 50. Number of message slots. |
| `talker` | String (int) | Current online user count. |
| `talk1`…`talk{sentence}` | String (HTML) | FIFO message ring. Slot 1 is always newest. On each new message all slots shift down by 1, oldest drops off. |
| `visitnam1`…`visitnam{talker}` | String | Online users list. Slot 1 is most recent join. Same shift-down pattern as messages. |
| `visitsex1`…`visitsex{talker}` | String | Sex field (legacy, always empty — no `sex` column in DB). |

### Page Flow

```
index.jsp  →  checkuser.jsp  →  login.jsp  →  frame.jsp
                                                  ├─ frame0.jsp  (chat display, auto-refresh)
                                                  ├─ frame1.jsp  (input bar + send button)
                                                  └─ frame2.jsp  (online users sidebar, 5s refresh)

frame1.jsp  →  talking.jsp  →  frame0.jsp   (message submit)
frame1.jsp  →  logout.jsp                   (exit, closes window)
```

- `frame.jsp` is a `<frameset>` (not a normal HTML page). It splits the view: left 79% holds frame0 (65% tall) over frame1 (35% tall); right 21% is frame2.
- `login.jsp` performs all `application` scope initialization (first login seeds all 50 slots to `""`). It does not render HTML — it only sets session/application state then redirects to `frame.jsp`.
- `talking.jsp` does not render HTML — it shifts messages in `application` scope and redirects to `frame0.jsp`.
- `logout.jsp` removes the user from the `visitnam` array (compacting the array, decrementing `talker`), pushes a goodbye message, then uses `window.onload = self.close()` to close the frame.

### Java Classes

- `bean.Dbcon` — single static method `getConnction()` (sic) returning a `java.sql.Connection`. Called directly from `checkuser.jsp`. **Always use `PreparedStatement`, never `Statement`.**
- `filter.CharacterEncodingFilter` — sets UTF-8 on every request via `/*` filter mapping in `web.xml`. Uses `jakarta.servlet.*` imports (Jakarta EE, not `javax.servlet`).

### Security Constraints

- All user input must be HTML-escaped before storing in `application` scope or rendering to the page. Use `.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")`.
- `checkuser.jsp` must use `PreparedStatement` with `?` parameters — never string concatenation in SQL.

### UI Style

All pages use a consistent Apple-inspired light liquid-glass design:
- Animated flowing gradient background: `linear-gradient(-45deg, #f5f5f7, #e2d1f9, #e5f0fb, #d4e4f7)` with `background-size:400% 400%; animation: fluidGradient 15s ease infinite`
- Frosted glass panels: `background: rgba(255,255,255,0.55); backdrop-filter: blur(28px) saturate(200%)`
- Dynamic Island accent: dark pill `rgba(0,0,0,0.86)` with `border-radius:999px`
- Apple blue accent: `#0071e3`
