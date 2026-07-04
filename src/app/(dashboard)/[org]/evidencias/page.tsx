import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function EvidenciasPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Evidências</h1>
        <p className="text-muted-foreground">
          Upload e gerenciamento de evidências de conformidade.
        </p>
      </div>
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Evidências Recentes</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Nenhuma evidência cadastrada ainda. Vincule arquivos ou anotações aos controles
            para demonstrar conformidade.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
