package org.depinfo.serveur.model;

public class ScoreResultat {
    private int victoires;
    private int defaites;
    private int totalMatchs;
    private int tauxVictoire;
    private String rang;

    public ScoreResultat() {
    }

    public ScoreResultat(int victoires, int defaites, int totalMatchs, int tauxVictoire, String rang) {
        this.victoires = victoires;
        this.defaites = defaites;
        this.totalMatchs = totalMatchs;
        this.tauxVictoire = tauxVictoire;
        this.rang = rang;
    }

    public int getVictoires() {
        return victoires;
    }

    public void setVictoires(int victoires) {
        this.victoires = victoires;
    }

    public int getDefaites() {
        return defaites;
    }

    public void setDefaites(int defaites) {
        this.defaites = defaites;
    }

    public int getTotalMatchs() {
        return totalMatchs;
    }

    public void setTotalMatchs(int totalMatchs) {
        this.totalMatchs = totalMatchs;
    }

    public int getTauxVictoire() {
        return tauxVictoire;
    }

    public void setTauxVictoire(int tauxVictoire) {
        this.tauxVictoire = tauxVictoire;
    }

    public String getRang() {
        return rang;
    }

    public void setRang(String rang) {
        this.rang = rang;
    }
}
