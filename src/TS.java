
import compilerTools.Token;
import javax.swing.table.DefaultTableModel;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;


/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */

/**
 *
 * @author Francisco Miranda
 */
public class TS extends javax.swing.JFrame {

    /**
     * Creates new form TS
     */
    public TS(ArrayList tokens) {
        initComponents();
        this.tokens = tokens;
        setTitle("Tabla de simbolos");
        setVisible(true);
        setDefaultCloseOperation(javax.swing.JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);
        
        fillStaticTable();
        fillVariableTable();
    }
    private void fillStaticTable(){
        DefaultTableModel model1 = (DefaultTableModel) tblFija.getModel();
        String pa;
        for(String palabra : palabras){
            pa = "Palabra_Reservada";
            switch (palabra) {
                case "entero":
                case "cadena":
                case "hora":    
                case "evento":
                case "estructura":
                case "enumeraciones":
                case "estados":
                    pa = ""+palabra;
                    break;
                case "bool":
                    pa = "logico";
                    break;
                case "float":
                    pa = "flotante";
                    break;
                default:
                    break;
            }
        Object[] objeto = {palabra, pa}; 
        model1.addRow(objeto);
        }
    }
    private void fillVariableTable() {
    DefaultTableModel model = (DefaultTableModel) tblVariable.getModel();
    Set<String> identifiers = new HashSet<>();
    Map<String, List<Integer>> identifierLines = new HashMap<>();
    
    for (Token token : tokens) {
        if ("IDENTIFICADOR".equals(token.getLexicalComp())) {
            String lexeme = token.getLexeme();
            if (!identifiers.contains(lexeme)) {
                identifiers.add(lexeme);
                identifierLines.put(lexeme, new ArrayList<>());
            }
            identifierLines.get(lexeme).add(token.getLine());
        }
    }
    
    int rowNum = 1;
    for (String identifier : identifiers) {
        List<Integer> lines = identifierLines.get(identifier);
        Collections.sort(lines); // Ordenar las líneas
        String lineStr = lines.stream()
                              .map(Object::toString)
                              .collect(Collectors.joining(", ")); // Concatenar las líneas
        Object[] rowData = {rowNum, identifier, "", "", "", "", lineStr};
        model.addRow(rowData);
        rowNum++;
    }
}


    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tblVariable = new javax.swing.JTable();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane2 = new javax.swing.JScrollPane();
        tblFija = new javax.swing.JTable();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jTabbedPane1.setPreferredSize(new java.awt.Dimension(760, 400));

        jPanel1.setPreferredSize(new java.awt.Dimension(760, 400));
        jPanel1.setLayout(new java.awt.BorderLayout());

        tblVariable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "#", "Nombre Var.", "Dirección", "Tipo", "Valor", "Línea Declaración", "Línea Referenciada"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jScrollPane1.setViewportView(tblVariable);

        jPanel1.add(jScrollPane1, java.awt.BorderLayout.CENTER);

        jTabbedPane1.addTab("Variable", jPanel1);

        jPanel2.setPreferredSize(new java.awt.Dimension(760, 400));
        jPanel2.setLayout(new java.awt.BorderLayout());

        tblFija.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Lexema", "Componente Lexico"
            }
        ));
        jScrollPane2.setViewportView(tblFija);

        jPanel2.add(jScrollPane2, java.awt.BorderLayout.CENTER);

        jTabbedPane1.addTab("Fija", jPanel2);

        getContentPane().add(jTabbedPane1, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    
    private  String[] palabras = new String[]{
    "float", "entero", "bool", "temperatura", "cadena", "sensor", 
    "infrarrojo", "hora", "beber", "evento", "alimentar", "encender", "apagar", 
    "nuevo", "funciona", "inicio_granja", "fin_granja", "edd", 
    "sdd", "alarma", "detener", "esperar", "configurar", "devuelve",
    "con_retorno", "definir", "leer_sensor", "si", 
    "fin_si", "contrario", "contrario_si", "segun", 
    "caso", "termina", "fin_segun", "para", 
    "hasta", "incrementa", "fin_para", "fin_funcion", 
    "mientras", "funcion", "inicio_programa", "fin_programa",
    "dispositivos", "fin_dispositivos", "estructura", "enumeraciones",
    "estados", "ventilador", "alimentador",
    "evento","+","-","*",
    "/", ">","<","<=",
    ">=","==","!=","=",
    ";",";",",","and","or","(",
    ")","{","}",
    "#","/"
    };      
    
    public ArrayList<Token> tokens;
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JTable tblFija;
    private javax.swing.JTable tblVariable;
    // End of variables declaration//GEN-END:variables
}