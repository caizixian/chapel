use IO;

/* Tests a user-submitted bug with the channel.advance() function */
proc main() {
  var f = open('advance.txt', iomode.r),
      c = f.reader(),
      err: syserr;


  writeln(c.read(int));
  writeln(c.read(int));
  c.advance(8, err);
  writeln(c.read(int));
  writeln(c.read(int));
}
