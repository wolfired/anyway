package test.anyway.geometry
{
	import anyway.geometry.AWVector;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	
	public class AWVectorTester
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testAddition():void{
			var v1:AWVector = new AWVector(3, 2, 1);
			var v2:AWVector = new AWVector(1, 2, 3);
			var v3:AWVector = new AWVector(4, 4, 4);
			v1.addition(v2);
			assertTrue(v1.isCongruent(v3));
		}
		
		[Test]
		public function testDotProduct():void{
			var v1:AWVector = new AWVector(3, 2, 1);
			var v2:AWVector = new AWVector(1, 2, 3);
			var result:Number = v1.dotProduct(v2);
			assertEquals(result, 10);
		}
	}
}