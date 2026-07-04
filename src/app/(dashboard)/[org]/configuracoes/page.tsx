import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function ConfiguracoesPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Configurações</h1>
        <p className="text-muted-foreground">
          Gerencie sua organização, membros e preferências.
        </p>
      </div>
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Organização</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Configure dados da organização, convide membros e gerencie permissões.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
