import http from "k6/http";
import { group, check } from "k6";
import { scenario } from 'k6/execution';
import { randomString } from 'https://jslib.k6.io/k6-utils/1.2.0/index.js';

const url = `http://${__ENV.APP_HOST}:3000`;

export const options = {
    scenarios: {
        'scenarios': {
            executor: 'shared-iterations',
            vus: 10,
            iterations: 10000,
        },
    }
};
export default function () {
    const params = {
        headers: {
            'Content-Type': 'application/json',
        }
    };

    const uuid = ('10000000' + scenario.iterationInTest).slice(-8);
    const body = randomString(100);
    const requestBody = JSON.stringify({
        title: uuid,
        body: body,
        status: "public"
    });

    group("/articles", () => {
        const response = http.post(`${url}/articles`, requestBody, params);
        check(response, {
            'is status 200': (r) => r.status === 201,
        });
    });
}
