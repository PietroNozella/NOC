import { createClient } from "@/lib/supabase/server";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

const statusVariant: Record<string, "default" | "secondary" | "destructive" | "outline"> = {
  compliant: "default",
  non_compliant: "destructive",
  in_progress: "secondary",
  not_assessed: "outline",
  not_applicable: "outline",
};

export default async function ControlesPage() {
  const supabase = await createClient();

  const { data: controls } = await supabase
    .from("controls")
    .select("id, control_id, name, description, risk_level, domain_id, framework_id")
    .order("control_id");

  const { data: statuses } = await supabase
    .from("control_status")
    .select("control_id, status");

  const statusMap = new Map(statuses?.map((s) => [s.control_id, s.status]));

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Controles</h1>
        <p className="text-muted-foreground">
          Catálogo de controles de compliance e seus status.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Todos os Controles</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>ID</TableHead>
                <TableHead>Nome</TableHead>
                <TableHead>Nível de Risco</TableHead>
                <TableHead>Status</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {controls?.length === 0 && (
                <TableRow>
                  <TableCell colSpan={4} className="text-center text-muted-foreground">
                    Nenhum controle encontrado. Execute os seeds SQL primeiro.
                  </TableCell>
                </TableRow>
              )}
              {controls?.map((control) => {
                const status = statusMap.get(control.id) ?? "not_assessed";
                return (
                  <TableRow key={control.id}>
                    <TableCell className="font-mono text-xs">
                      {control.control_id}
                    </TableCell>
                    <TableCell className="font-medium">{control.name}</TableCell>
                    <TableCell>
                      {control.risk_level && (
                        <Badge
                          variant={
                            control.risk_level === "critical"
                              ? "destructive"
                              : control.risk_level === "high"
                                ? "default"
                                : "secondary"
                          }
                        >
                          {control.risk_level}
                        </Badge>
                      )}
                    </TableCell>
                    <TableCell>
                      <Badge variant={statusVariant[status] ?? "outline"}>
                        {status}
                      </Badge>
                    </TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
