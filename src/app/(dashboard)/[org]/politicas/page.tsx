import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function PoliticasPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Políticas</h1>
        <p className="text-muted-foreground">
          Criação e gestão de políticas de segurança e privacidade.
        </p>
      </div>
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Políticas da Organização</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Nenhuma política cadastrada ainda. Crie políticas e vincule-as a controles de
            compliance.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
