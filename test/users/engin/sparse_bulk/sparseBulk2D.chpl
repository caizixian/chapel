use LayoutCS;

config const N = 8;

const ParentDom = {0..#N, 0..#N};

config type layoutType = DefaultDist;
var layout = new layoutType;
var SparseDom: sparse subdomain(ParentDom) dmapped new dmap(layout);

var SparseMat: [SparseDom] int;

//create a small dense chunk somewhere in vector
const denseChunk = {1..3, 5..7}; 

SparseDom += denseChunk; //not sure if this would work

for i in denseChunk do SparseMat[i]=i[1]+i[2];

writeln("Dense chunk:");
for i in ParentDom.dim(1) {
  for j in ParentDom.dim(2) {
    write(SparseMat[i,j], " ");
  }
  writeln();
}

//create a strided chunk
var stridedChunk = {1..6 by 2, 1..3};

SparseDom += stridedChunk;

for i in stridedChunk do SparseMat[i]=i[1]+i[2];

writeln("Dense + strided chunk:");
for i in ParentDom.dim(1) {
  for j in ParentDom.dim(2) {
    write(SparseMat[i,j], " ");
  }
  writeln();
}

//create diagonal indices
var diagIndArr : [{17..#2*N }] 2*int;
for i in ParentDom.dim(1) {
  diagIndArr[diagIndArr.domain.low+i*2] = (i, i);
  diagIndArr[diagIndArr.domain.low+i*2+1] = (i, N-1-i);
}

SparseDom += diagIndArr;

for i in diagIndArr do SparseMat[i]=i[1]+i[2];

writeln("Chunks + Diagonals:");
for i in ParentDom.dim(1) {
  for j in ParentDom.dim(2) {
    write(SparseMat[i,j], " ");
  }
  writeln();
}
