package test.anyway.geometry {

	import anyway.geometry.AWMatrix;
	
	import org.flexunit.asserts.assertTrue;

	public class AWMatrixTester {

		[BeforeClass]
		public static function setUpBeforeClass():void {
		}

		[AfterClass]
		public static function tearDownAfterClass():void {
		}

		[Before]
		public function setUp():void {
		}

		[After]
		public function tearDown():void {
		}

		[Test]
		public function testCopyColumnFrom():void {
			var t1:AWMatrix = new AWMatrix();
			t1.copyRawData(Vector.<Number>([
										   1, 2, 3, 4,
										   4, 3, 2, 1,
										   1, 3, 1, 4,
										   0, 3, 0, 4
										   ]));

			var m1:AWMatrix = new AWMatrix();
			m1.copyColumnFrom(0, Vector.<Number>([1, 4, 1, 0]));
			m1.copyColumnFrom(1, Vector.<Number>([2, 3, 3, 3]));
			m1.copyColumnFrom(2, Vector.<Number>([3, 2, 1, 0]));
			m1.copyColumnFrom(3, Vector.<Number>([4, 1, 4, 4]));

			assertTrue(t1.toString() == m1.toString());
		}

		[Test]
		public function testCopyColumnTo():void {
			var raw1:Vector.<Number> = Vector.<Number>([2, 3, 3, 3]);

			var m1:AWMatrix = new AWMatrix();
			m1.copyRawData(Vector.<Number>([
										   1, 2, 3, 4,
										   4, 3, 2, 1,
										   1, 3, 1, 4,
										   0, 3, 0, 4
										   ]));
			var raw2:Vector.<Number> = new Vector.<Number>();
			m1.copyColumnTo(1, raw2);

			assertTrue(raw1.toString() == raw2.toString());
		}

		[Test]
		public function testCopyRawData():void {
//			Assert.fail("Test method Not yet implemented");
		}

		[Test]
		public function testCopyRowFrom():void {
			var t1:AWMatrix = new AWMatrix();
			t1.copyRawData(Vector.<Number>([
										   1, 2, 3, 4,
										   4, 3, 2, 1,
										   1, 3, 1, 4,
										   0, 3, 0, 4
										   ]));

			var m1:AWMatrix = new AWMatrix();
			m1.copyRowFrom(0, Vector.<Number>([1, 2, 3, 4]));
			m1.copyRowFrom(1, Vector.<Number>([4, 3, 2, 1]));
			m1.copyRowFrom(2, Vector.<Number>([1, 3, 1, 4]));
			m1.copyRowFrom(3, Vector.<Number>([0, 3, 0, 4]));

			assertTrue(t1.toString() == m1.toString());
		}

		[Test]
		public function testCopyRowTo():void {
			var raw1:Vector.<Number> = Vector.<Number>([1, 3, 1, 4]);

			var m1:AWMatrix = new AWMatrix();
			m1.copyRawData(Vector.<Number>([
										   1, 2, 3, 4,
										   4, 3, 2, 1,
										   1, 3, 1, 4,
										   0, 3, 0, 4
										   ]));
			var raw2:Vector.<Number> = new Vector.<Number>();
			m1.copyRowTo(2, raw2);

			assertTrue(raw1.toString() == raw2.toString());
		}

		[Test]
		public function testMultiply():void {
//			Assert.fail("Test method Not yet implemented");
			var m1:AWMatrix = new AWMatrix();
			m1.copyRawData(Vector.<Number>([
				1, 1, 1, 1,
				2, 2, 2, 2,
				1, 1, 1, 1,
				2, 2, 2, 2
			]));
			var m2:AWMatrix = new AWMatrix();
			m2.copyRawData(Vector.<Number>([
				4, 3, 2, 1,
				4, 3, 2, 1,
				4, 3, 2, 1,
				4, 3, 2, 1
			]));
			var m3:AWMatrix = new AWMatrix();
			m3.copyRawData(Vector.<Number>([
				16, 12, 8, 4,
				32, 24, 16, 8,
				16, 12, 8, 4,
				32, 24, 16, 8
			]));
			assertTrue(m1.multiply(m2).toString() == m3.toString());
		}

		[Test]
		public function testRotate():void {
//			Assert.fail("Test method Not yet implemented");
		}

		[Test]
		public function testScale():void {
//			Assert.fail("Test method Not yet implemented");
		}

		[Test]
		public function testTranslate():void {
//			Assert.fail("Test method Not yet implemented");
		}

		[Test]
		public function testTranspose():void {
//			Assert.fail("Test method Not yet implemented");
		}
	}
}
