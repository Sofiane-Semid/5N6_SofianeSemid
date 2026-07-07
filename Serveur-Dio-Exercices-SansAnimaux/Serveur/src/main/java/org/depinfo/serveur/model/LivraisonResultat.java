package org.depinfo.serveur.model;

public class LivraisonResultat {
    private int distance;
    private int poids;
    private int fraisDistance;
    private int fraisPoids;
    private int total;
    private boolean livraisonGratuite;

    public LivraisonResultat() {
    }

    public LivraisonResultat(int distance, int poids, int fraisDistance, int fraisPoids, int total, boolean livraisonGratuite) {
        this.distance = distance;
        this.poids = poids;
        this.fraisDistance = fraisDistance;
        this.fraisPoids = fraisPoids;
        this.total = total;
        this.livraisonGratuite = livraisonGratuite;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }

    public int getPoids() {
        return poids;
    }

    public void setPoids(int poids) {
        this.poids = poids;
    }

    public int getFraisDistance() {
        return fraisDistance;
    }

    public void setFraisDistance(int fraisDistance) {
        this.fraisDistance = fraisDistance;
    }

    public int getFraisPoids() {
        return fraisPoids;
    }

    public void setFraisPoids(int fraisPoids) {
        this.fraisPoids = fraisPoids;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public boolean isLivraisonGratuite() {
        return livraisonGratuite;
    }

    public void setLivraisonGratuite(boolean livraisonGratuite) {
        this.livraisonGratuite = livraisonGratuite;
    }
}
