//wrong architechture, wrong organisation
pragma solidity ^0.4.19;
contract WhoIsWinner{

  struct Joueur {

    uint8 id;
    string nom;
    uint16 number;
  }

  Joueur[] public joueurs;

  constructor(string _nom1, string _nom2) public {
      createJoueur(1, _nom1);
      createJoueur(2, _nom2);
  }

  function createJoueur(uint8 _id, string _nom) public {
    joueurs.push(Joueur(_id, _nom, 0));
  }

  function _generateRandomNumber(string str) public returns (uint16) {
    uint rand = uint(keccak256(str));
    return uint16(rand % 100);
  }

  function jouer() public returns (string) {
      Joueur j1 = joueurs[1];
      Joueur j2 = joueurs[2];
    j1.number = _generateRandomNumber(j1.nom);
    j2.number = _generateRandomNumber(j2.nom);
    if(j1.number > j2.number){
      return j1.nom;
    } else {
      return j2.nom;
    }
  }
}
