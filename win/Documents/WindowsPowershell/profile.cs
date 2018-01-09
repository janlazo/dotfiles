using System.Security.Principal;

public static class Profile
{
    public static bool IsAdmin()
    {
        WindowsIdentity user = WindowsIdentity.GetCurrent();
        WindowsPrincipal group = new WindowsPrincipal(user);
        return group.IsInRole(WindowsBuiltInRole.Administrator);
    }
}
