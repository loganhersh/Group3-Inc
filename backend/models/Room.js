/*
  May or may not be used. To be determined, but currently not in use.
 */
class Room {
  constructor(id, type, isUsable, price) {
    this.roomId = id;
    this.roomType = type;
    this.isUsable = isUsable;
    this.basePrice = price;
  }

  get id() {
    return this.roomId;
  }

  set basePrice(price) {
    if(typeof price === 'number' && price > 0) {
      this.basePrice = price;
    }
  }

  set isUsable(isUsable) {
    if(typeof isUsable === 'boolean') {
      this.isUsable = isUsable;
    }
  }
}
