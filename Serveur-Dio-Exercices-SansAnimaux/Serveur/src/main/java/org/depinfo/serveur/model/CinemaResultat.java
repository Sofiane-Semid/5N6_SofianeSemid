package org.depinfo.serveur.model;

public class CinemaResultat {
    private int age;
    private String jour;
    private String categorie;
    private int prixBase;
    private int rabais;
    private int prixFinal;
    private String message;

    public CinemaResultat() {
    }

    public CinemaResultat(int age, String jour, String categorie, int prixBase, int rabais, int prixFinal, String message) {
        this.age = age;
        this.jour = jour;
        this.categorie = categorie;
        this.prixBase = prixBase;
        this.rabais = rabais;
        this.prixFinal = prixFinal;
        this.message = message;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getJour() {
        return jour;
    }

    public void setJour(String jour) {
        this.jour = jour;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public int getPrixBase() {
        return prixBase;
    }

    public void setPrixBase(int prixBase) {
        this.prixBase = prixBase;
    }

    public int getRabais() {
        return rabais;
    }

    public void setRabais(int rabais) {
        this.rabais = rabais;
    }

    public int getPrixFinal() {
        return prixFinal;
    }

    public void setPrixFinal(int prixFinal) {
        this.prixFinal = prixFinal;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
