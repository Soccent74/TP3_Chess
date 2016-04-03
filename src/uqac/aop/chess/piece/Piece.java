package uqac.aop.chess.piece;

import uqac.aop.chess.agent.Move;

public abstract class Piece {
	 protected int player;
     
     public Piece() {
		// TODO Auto-generated constructor stub
	}
     
     public Piece(int player) {
		// TODO Auto-generated constructor stub
    	 setPlayer(player);
	}
	public int getPlayer() {
		try{
             return player;
		}
         catch (Exception e) {
        	 System.out.println("Pas de pièce à cet endroit.");
        	 return 2;
		}
     }
     public void setPlayer(int player) {
             this.player = player;
     }
     public abstract boolean isMoveLegal(Move mv);

     public abstract String toString();
     public void print(){
             System.out.println(this.toString()); 
     }
     @Override
	public Object clone() { 
		try{
			return super.clone();
		}
		catch (CloneNotSupportedException e){
			System.out.println(e);
		}
		return null;
	}
}
