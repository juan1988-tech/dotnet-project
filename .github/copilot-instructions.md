# Copilot Instructions for appNet Workspace

This workspace contains multiple independent .NET projects, mainly web APIs using the Minimal API pattern. Follow these guidelines to maximize productivity with AI coding agents:

## Architecture Overview
- Each API is in its own folder and is fully independent.
- No cross-API dependencies; each service can be built, tested, and deployed separately.
- Configuration is managed via `appsettings.json` and `appsettings.Development.json` in each API folder.
- Dockerfiles are present in each API folder for containerization.
- Test projects are named with `.Tests` suffix and use xUnit.

## Key Workflows
- **Build:**
  - `dotnet build MinimalApiProject/`
  - `dotnet build NETapp/MiWebAPI/`
- **Run:**
  - `dotnet run --project MinimalApiProject/`
  - `dotnet run --project NETapp/MiWebAPI/`
- **Test:**
  - `dotnet test MinimalApiProject.Tests/`
- **Docker:**
  - `docker build -t minimalapiproject MinimalApiProject/`
  - `docker build -t miwebapi NETapp/MiWebAPI/`
- **Project Generation:**
  - Use `generador.sh` to automate creation of new Minimal API projects and their test projects.

## Project Conventions
- APIs follow Minimal API pattern (see example below).
- Each API has its own settings and Dockerfile.
- No shared code between APIs.
- Tests are always in a separate `.Tests` project.
- Use xUnit for all unit tests.

## Example Minimal API
```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => "Hello World!");
app.Run();
```

## Integration Points
- No external dependencies between APIs.
- Each API can be containerized and deployed independently.
- For .NET upgrade instructions, see `.github/instructions/dotnet-upgrade.instructions.md` (if present).

## References
- [README.md](../README.md) for project structure and commands
- [Microsoft Docs: Minimal APIs](https://learn.microsoft.com/aspnet/core/fundamentals/minimal-apis)

---

**Tip:** When adding new APIs, follow the folder, naming, and configuration conventions above. Use `generador.sh` for consistency.
