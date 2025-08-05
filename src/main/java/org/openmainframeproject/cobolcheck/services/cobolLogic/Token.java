package org.openmainframeproject.cobolcheck.services.cobolLogic;

import java.util.Objects;

public class Token {

  public String token;
  public int offset;

  public Token(String token, int offset) {
    this.token = token;
    this.offset = offset;
  }

  @Override
  public String toString() {
    return token + ":" + offset;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    Token token1 = (Token) o;
    return offset == token1.offset && Objects.equals(token, token1.token);
  }

  @Override
  public int hashCode() {
    return Objects.hash(token, offset);
  }
}
