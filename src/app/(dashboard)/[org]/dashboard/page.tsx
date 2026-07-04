import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";

export default async function DashboardPage() {
  const supabase = await createClient();

  const { data: frameworks } = await supabase
    .from("frameworks")
    .select("id, name, slug, category")
    .or(`organization_id.is.null,is_public.eq.true`);

  const { data: profile } = await supabase
    .from("profiles")
    .select("name, role, organization_id")
    .single();

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Dashboard</h1>
        <p className="text-muted-foreground">
          Bem-vindo{profile?.name ? `, ${profile?.name}` : ""}!
          {profile?.role === "admin" ? " Você é administrador." : ""}
        </p>
      </div>

      {/* Overview Cards */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Frameworks
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-3xl font-bold">{frameworks?.length ?? 0}</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Controles
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-3xl font-bold">—</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Evidências
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-3xl font-bold">—</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Riscos
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-3xl font-bold">—</p>
          </CardContent>
        </Card>
      </div>

      {/* Frameworks */}
      <div className="grid gap-4 md:grid-cols-2">
        {frameworks?.map((fw) => (
          <Card key={fw.id}>
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-lg">
                {fw.name}
                <Badge variant="outline">{fw.slug}</Badge>
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-2">
              <div className="flex items-center justify-between text-sm">
                <span className="text-muted-foreground">Progresso</span>
                <span className="font-medium">0%</span>
              </div>
              <Progress value={0} />
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
}
