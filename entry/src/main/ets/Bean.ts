export namespace Beans {

  export class TestData {
    public field1: string
    public field2: number

    constructor(field1: string, field2: number) {
      this.field1 = field1
      this.field2 = field2
    }

    public toString() {
      return `${this.field1} -- ${this.field2}`
    }
  }


}