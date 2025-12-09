//Codigo APEX
//La funcion de este codigo tiene como objetivo analizar una lista de Strings y contar la cantidad de veces que se repite cada uno de ellos. 
public with sharing class ApexCode1 {

    public ApexCode1() {
        
        List<String> nombres = new List<String>{
            'Ana', 'Luis', 'Ana', 'Pedro', 'Luis', 'Ana', 'Juan'
        };

        Map<String, Integer> conteoNombre = new Map<String, Integer>();

        for(String nombre : nombres){
            if(conteoNombre.containsKey(nombre)){
                conteoNombre.put(nombre, conteoNombre.get(nombre) + 1);
            }else{
                conteoNombre.put(nombre, 1); 
            }
        }
    }
}