"use client";

import Link from "next/link";
import { useParams, usePathname } from "next/navigation";
import { createClient } from "@/lib/supabase/client";
import { useCallback, useEffect, useState } from "react";
import { Button } from "@/components/ui/button";
import {
  LayoutDashboard,
  ShieldCheck,
  FileText,
  ScrollText,
  AlertTriangle,
  ClipboardCheck,
  BarChart3,
  Settings,
  LogOut,
  ChevronLeft,
  ChevronRight,
  Menu,
  X,
} from "lucide-react";

const navItems = [
  { href: "dashboard", label: "Dashboard", icon: LayoutDashboard },
  { href: "controles", label: "Controles", icon: ShieldCheck },
  { href: "evidencias", label: "Evidências", icon: FileText },
  { href: "politicas", label: "Políticas", icon: ScrollText },
  { href: "riscos", label: "Riscos", icon: AlertTriangle },
  { href: "auditorias", label: "Auditorias", icon: ClipboardCheck },
  { href: "relatorios", label: "Relatórios", icon: BarChart3 },
  { href: "configuracoes", label: "Configurações", icon: Settings },
];

export function Sidebar() {
  const params = useParams();
  const pathname = usePathname();
  const org = params.org as string;
  const [collapsed, setCollapsed] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);
  const supabase = createClient();

  const handleLogout = useCallback(async () => {
    await supabase.auth.signOut();
    window.location.href = "/login";
  }, [supabase]);

  useEffect(() => {
    setMobileOpen(false);
  }, [pathname]);

  return (
    <>
      {/* Mobile toggle */}
      <button
        type="button"
        className="fixed left-4 top-4 z-50 flex size-10 items-center justify-center rounded-md border bg-background shadow lg:hidden"
        onClick={() => setMobileOpen(!mobileOpen)}
      >
        {mobileOpen ? <X className="size-5" /> : <Menu className="size-5" />}
      </button>

      {/* Overlay */}
      {mobileOpen && (
        <div
          className="fixed inset-0 z-30 bg-black/50 lg:hidden"
          onClick={() => setMobileOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside
        className={`fixed inset-y-0 left-0 z-40 flex flex-col border-r bg-background transition-all duration-200 lg:static ${
          collapsed ? "w-16" : "w-60"
        } ${mobileOpen ? "translate-x-0" : "-translate-x-full lg:translate-x-0"}`}
      >
        {/* Logo */}
        <div className="flex h-14 items-center border-b px-4">
          <Link
            href={`/${org}/dashboard`}
            className={`font-bold tracking-tight ${collapsed ? "hidden" : "block"}`}
          >
            TrustLog
          </Link>
          <button
            type="button"
            onClick={() => setCollapsed(!collapsed)}
            className="ml-auto hidden lg:block"
          >
            {collapsed ? (
              <ChevronRight className="size-4" />
            ) : (
              <ChevronLeft className="size-4" />
            )}
          </button>
        </div>

        {/* Nav */}
        <nav className="flex-1 space-y-1 p-2">
          {navItems.map((item) => {
            const href = `/${org}/${item.href}`;
            const active = pathname === href || pathname.startsWith(`${href}/`);

            return (
              <Link
                key={item.href}
                href={href}
                className={`flex items-center gap-3 rounded-md px-3 py-2 text-sm transition-colors ${
                  active
                    ? "bg-primary/10 font-medium text-primary"
                    : "text-muted-foreground hover:bg-accent hover:text-accent-foreground"
                } ${collapsed ? "justify-center" : ""}`}
                title={item.label}
              >
                <item.icon className="size-5 shrink-0" />
                {!collapsed && <span>{item.label}</span>}
              </Link>
            );
          })}
        </nav>

        {/* Footer */}
        <div className="border-t p-2">
          <Button
            variant="ghost"
            className={`w-full gap-3 ${collapsed ? "justify-center px-2" : ""}`}
            onClick={handleLogout}
          >
            <LogOut className="size-5 shrink-0" />
            {!collapsed && <span>Sair</span>}
          </Button>
        </div>
      </aside>
    </>
  );
}
