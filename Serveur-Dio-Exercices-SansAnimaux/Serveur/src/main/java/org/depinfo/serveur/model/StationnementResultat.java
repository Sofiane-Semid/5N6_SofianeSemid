package org.depinfo.serveur.model;

public class StationnementResultat {
    private int heures;
    private String zone;
    private int tarifHeure;
    private boolean maximumAtteint;
    private int total;

    public StationnementResultat() {
    }

    public StationnementResultat(int heures, String zone, int tarifHeure, boolean maximumAtteint, int total) {
        this.heures = heures;
        this.zone = zone;
        this.tarifHeure = tarifHeure;
        this.maximumAtteint = maximumAtteint;
        this.total = total;
    }

    public int getHeures() {
        return heures;
    }

    public void setHeures(int heures) {
        this.heures = heures;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }

    public int getTarifHeure() {
        return tarifHeure;
    }

    public void setTarifHeure(int tarifHeure) {
        this.tarifHeure = tarifHeure;
    }

    public boolean isMaximumAtteint() {
        return maximumAtteint;
    }

    public void setMaximumAtteint(boolean maximumAtteint) {
        this.maximumAtteint = maximumAtteint;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
}
