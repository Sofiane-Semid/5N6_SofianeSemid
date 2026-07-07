package org.depinfo.serveur.model;

public class Erreur {
    private String message;

    public Erreur() {
    }

    public Erreur(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
