/*************************************************************************************************
* This file is part of the Nebula Framework project, released under the MIT License.             *
* See LICENSE file or go to https://github.com/jongpie/NebulaFramework for full license details. *
*************************************************************************************************/
@isTest
private class AggregateResultQueryBuilder_Tests {

    @isTest
    static void it_should_build_a_ridiculous_query_string() {
        String expectedString = 'SELECT Type,\nCOUNT() COUNT, COUNT_DISTINCT(OwnerId) COUNT_DISTINCT_OwnerId, MAX(CreatedDate) MAX_CreatedDate, MIN(CreatedDate) MIN_CreatedDate';
        expectedString += '\nFROM Case';
        expectedString += '\nGROUP BY Type';

        AggregateResultQueryBuilder aggregateResultQueryBuilder = (AggregateResultQueryBuilder)new AggregateResultQueryBuilder()
            // TODO the order of the method chaining shouldn't matter - the fields & aggregate functions should be sorted so its consistent
            .groupBy(Schema.Case.Type)
            .max(Schema.Case.CreatedDate)
            .count_distinct(Schema.Case.OwnerId)
            .min(Schema.Case.CreatedDate)
            .count()
            .setSObjectType(Schema.Case.SObjectType);
        String returnedQueryString = aggregateResultQueryBuilder.getQuery();

        System.assertEquals(expectedString, returnedQueryString);
    }


}