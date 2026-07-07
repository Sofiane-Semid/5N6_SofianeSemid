package org.depinfo.serveur.model;

public class RestaurantResultat {
    private int prixRepas;
    private int pourboire;
    private int montantPourboire;
    private int taxes;
    private int total;

    public RestaurantResultat() {
    }

    public RestaurantResultat(int prixRepas, int pourboire, int montantPourboire, int taxes, int total) {
        this.prixRepas = prixRepas;
        this.pourboire = pourboire;
        this.montantPourboire = montantPourboire;
        this.taxes = taxes;
        this.total = total;
    }

    public int getPrixRepas() {
        return prixRepas;
    }

    public void setPrixRepas(int prixRepas) {
        this.prixRepas = prixRepas;
    }

    public int getPourboire() {
        return pourboire;
    }

    public void setPourboire(int pourboire) {
        this.pourboire = pourboire;
    }

    public int getMontantPourboire() {
        return montantPourboire;
    }

    public void setMontantPourboire(int montantPourboire) {
        this.montantPourboire = montantPourboire;
    }

    public int getTaxes() {
        return taxes;
    }

    public void setTaxes(int taxes) {
        this.taxes = taxes;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
}
